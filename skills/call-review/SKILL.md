---
name: call-review
description: >
  This skill should be used when the user asks "why did this call go badly",
  "review my calls", "find calls where the lead mentioned X", "check the QA
  scorecard", "what are people objecting to", or wants transcripts,
  recordings, or call outcomes analyzed in Eqho.
metadata:
  version: "0.1.0"
---

# Eqho Call Review

Review individual calls or patterns across many calls.

## Single call

1. Locate the call with `get_call` (by ID) or `list_calls` (by lead, campaign, or date).
2. Read the transcript and pull `get_call_scorecard` for grader results.
3. Report what happened in plain language: the opening, where the conversation turned, the outcome, and which scorecard checks failed with the grader's reasoning.
4. Suggest specific changes to the agent role or script tied to the failure. Offer to apply them, but do not call `update_role` or `update_agent` without a clear yes, since live agents pick up role changes on their next call.

## Patterns across calls

1. Use `search_conversations` for keyword or topic searches across transcripts.
2. Group findings into themes (objections, competitor mentions, confusion points) with a count and one or two short paraphrased examples each.
3. Keep caller personal details out of the summary unless the user asks about a specific lead.

## Changing outcomes

Only call `update_call_disposition` when the user explicitly asks. It overwrites the stored outcome and changes reporting.
