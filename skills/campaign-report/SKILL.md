---
name: campaign-report
description: >
  This skill should be used when the user asks "how did my campaign do",
  "show me campaign performance", "pull the numbers for last week",
  "compare my campaigns", or wants connect rates, dispositions, appointments,
  or credit usage from Eqho.
metadata:
  version: "0.1.0"
---

# Eqho Campaign Report

Produce a clear performance readout for one or more Eqho campaigns.

## Steps

1. Call `get_context` to confirm the active organization. If the user names a client or account, use `search_organizations` and `switch_organization` before pulling data. State which org the numbers are from.
2. Resolve the campaign with `list_campaigns`. If several match, ask which one rather than guessing.
3. Pull headline numbers with `get_dashboard` (campaign-scoped). Use `query_metrics` for date ranges, trends, or credit usage.
4. Pull the disposition breakdown with `list_dispositions` so outcome labels match the org's own setup.
5. Default the date range to the last 7 days when the user does not give one, and say so.

## Output

Lead with two or three sentences on what matters (up, down, or off). Follow with a compact table of total calls, connects, connect rate, top dispositions, and booked or converted outcomes. Close with one or two concrete next moves.

Never invent a metric the tools did not return. If a number is missing, say it is missing.
