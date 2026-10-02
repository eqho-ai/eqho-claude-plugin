# Paste this into Claude Code, opened in the eqho MCP server repo

We're submitting the Eqho MCP server (https://mcp.eqho.ai/mcp) and plugin to the Anthropic Claude directory. Get the server review-ready:

1. Every tool must have MCP annotations. Set `title`, and `readOnlyHint: true` on every list_/get_/search_/query_ tool plus get_context, discover_capabilities, help, my_access, campaign_checklist, a2p_status. Set `destructiveHint: true` on release_phone_number, update_campaign_tasks (overwrites whole array), update_call_disposition, update_role, update_agent, update_campaign. Set `openWorldHint: true` on call_now, sms_now, claim_phone_number, set_campaign_status, upload_leads. Show me a table of every tool and its annotations before committing.
2. Confirm OAuth: /.well-known/oauth-protected-resource exists, auth server advertises PKCE S256, accepts form-urlencoded token requests, and allows redirect https://claude.ai/api/mcp/auth_callback plus localhost loopback for Claude Code.
3. Confirm Origin header validation on the MCP endpoint.
4. Tool descriptions: no instructions aimed at the model beyond describing the tool (no "always call X first" style prompt injection), under ~1k chars each.
5. Run the test suite, then open a PR. Don't deploy without asking me.

Then cd to the plugin repo and run: bash submission/submit.sh
