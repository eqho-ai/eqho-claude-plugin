---
name: campaign-launch
description: >
  This skill should be used when the user asks to "set up a new campaign",
  "build an agent", "launch a calling campaign", "create a voice agent for X",
  or "get this campaign ready to go live" in Eqho.
metadata:
  version: "0.1.0"
---

# Eqho Campaign Launch

Stand up a new agent and campaign, staged for approval before anything dials.

## Steps

1. Confirm the active org with `get_context`.
2. Gather the essentials, asking only for what is missing: goal of the calls, who is being called, call window and time zone, desired voice, and what counts as a success outcome.
3. Draft the role (agent instructions) and show it. On approval, call `create_role`.
4. Pick a voice with `list_voices`, then `create_agent` with the role attached.
5. Call `create_campaign` with the agent, call window, and dispositions. Leave it stopped.
6. Run `campaign_checklist` and report every failing check in plain language. Check `a2p_status` if the campaign will send SMS.
7. Check `list_phone_numbers` first. Only use `search_phone_numbers` and `claim_phone_number` if the user agrees to buy a number.

## Hard rules

- Never call `set_campaign_status` to start dialing, `upload_leads`, `call_now`, `sms_now`, or `claim_phone_number` without an explicit yes for that specific action. These cost money or contact real people.
- Never call `release_phone_number` unless the user names the number. It is irreversible.
- End with a short summary: what was created, what still fails the checklist, and what needs approval to go live.
