#!/usr/bin/env bash
# Eqho plugin: pre-submission checks + publish to GitHub.
# Run from the repo root:  bash submission/submit.sh
# Needs: claude CLI, gh CLI (logged in), curl, jq
set -euo pipefail

GH_ORG="${GH_ORG:-eqho-ai}"
REPO="${REPO:-eqho-claude-plugin}"
MCP_URL="https://mcp.eqho.ai/mcp"
BASE="https://mcp.eqho.ai"

pass(){ echo "  ✅ $1"; }
fail(){ echo "  ❌ $1"; FAILED=1; }
FAILED=0

echo "1) Plugin structure"
if command -v claude >/dev/null; then
  claude plugin validate .claude-plugin/plugin.json && pass "claude plugin validate" || fail "claude plugin validate"
else
  fail "claude CLI not found (npm i -g @anthropic-ai/claude-code)"
fi
grep -rn "REPLACE_\|TODO" --include=*.json --include=*.md . | grep -v submission/ && fail "Placeholders left (fix lines above)" || pass "No placeholders"

echo "2) MCP endpoint"
code=$(curl -s -o /dev/null -w '%{http_code}' -X POST "$MCP_URL" -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' -d '{"jsonrpc":"2.0","id":1,"method":"ping"}' || true)
[[ "$code" == "401" || "$code" == "200" ]] && pass "Reachable (HTTP $code)" || fail "Unexpected HTTP $code from $MCP_URL"

echo "3) OAuth discovery (directory requirement)"
prm=$(curl -s "$BASE/.well-known/oauth-protected-resource" || true)
echo "$prm" | jq -e '.authorization_servers' >/dev/null 2>&1 && pass "Protected resource metadata" || fail "Missing /.well-known/oauth-protected-resource"
AS=$(echo "$prm" | jq -r '.authorization_servers[0] // empty' 2>/dev/null)
AS="${AS:-$BASE}"
asm=$(curl -s "$AS/.well-known/oauth-authorization-server" || true)
echo "$asm" | jq -e '.code_challenge_methods_supported | index("S256")' >/dev/null 2>&1 && pass "PKCE S256 advertised" || fail "PKCE S256 not advertised at $AS"
echo "  ℹ️  Make sure https://claude.ai/api/mcp/auth_callback is an allowed redirect URI."

if [[ "$FAILED" == 1 ]]; then echo; echo "Fix the ❌ items, then rerun."; exit 1; fi

echo "4) Publish to GitHub"
read -rp "Create/push github.com/$GH_ORG/$REPO (private)? [y/N] " ok
if [[ "$ok" == "y" ]]; then
  [[ -d .git ]] || git init -q
  git add -A && git commit -qm "Eqho Claude plugin v$(jq -r .version .claude-plugin/plugin.json)" || true
  gh repo view "$GH_ORG/$REPO" >/dev/null 2>&1 || gh repo create "$GH_ORG/$REPO" --private --source=. --remote=origin
  git branch -M main && git push -u origin main
  pass "Pushed: https://github.com/$GH_ORG/$REPO"
fi

echo "5) Submit"
echo "  Open https://claude.ai/admin-settings/directory/submissions/new"
echo "  Paste answers from submission/FORM_ANSWERS.md"
