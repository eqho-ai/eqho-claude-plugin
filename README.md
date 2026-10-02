# Eqho for Claude

Eqho is a voice AI platform for businesses that live on the phone. Our AI agents make and take real calls, follow up by text, and log every conversation with a transcript, recording, and outcome. This plugin puts the platform inside Claude.

## What's included

- **Eqho MCP connector** (`https://mcp.eqho.ai/mcp`): campaigns, agents, roles, voices, calls, transcripts, QA scorecards, leads, phone numbers, SMS registration status, dashboards, and metrics across every org you can access.
- **Skills**
  - `campaign-report`: performance readouts with connect rate, dispositions, and next moves.
  - `call-review`: single-call breakdowns and pattern searches across transcripts.
  - `campaign-launch`: builds the role, agent, and campaign, runs the launch checklist, and stages everything for your approval.

## Setup

Install the plugin, then sign in to Eqho when Claude prompts you (OAuth). No API keys or environment variables needed.

## Example prompts

- "Show me connect rate, appointments booked, and top dispositions for my solar campaign over the last 7 days."
- "Find calls this week where the lead mentioned a competitor and summarize what they said."
- "Create a new agent for our insurance renewal campaign using a warm female voice, then run the campaign checklist and tell me what's missing before launch."
- "Switch to the Acme Roofing org and tell me which campaigns are live right now."

## Safety

Anything that costs money or contacts a real person (placing a call, sending SMS, starting a campaign, uploading leads, claiming a number) requires your approval every time. Releasing a phone number is irreversible and flagged as such.

## Privacy Policy

https://eqho.ai/privacy

Data accessed through this plugin stays scoped to the Eqho organizations your account can access.

## Support

support@eqho.ai
