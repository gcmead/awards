# Awards

Plan trips on points and miles with Claude. You describe the trip; Claude searches award
space across several departure airports and dates, works out which card points to transfer where,
checks your balances against the whole party, and suggests a plan. You book it yourself.
Claude never transfers points and never books.

It has two parts: the **Awards connector** (a server run by Gavin that does the searching and keeps
your profile and saved trips) and the **award-trip skill** (instructions that tell Claude how to
use it well).

## Prerequisites

Awards is built around **seats.aero Pro**, which costs about $10 a month (check seats.aero for
current pricing). Pro gives you an API key, and the server uses it to run searches for you.

- **Without Pro** you still get advisor mode: near-term award search through the free seats.aero
  connector (departures within 60 days), transfer advice, award release dates, and cash
  comparison through SlickTrip. Claude says what it could not search.
- **With Pro** you also get the sweep (many airports, destinations and dates in one go) and a
  year-ahead horizon.

To confirm Pro is working for you: sign in at seats.aero, open Settings, and look for an **API** tab.
If the tab is there, you can create a key. If it is missing, Pro is not active on that account yet.

## Set up: claude.ai (web and phone)

1. Settings, Connectors, add a custom connector with URL `https://awards.winemcp.com/mcp`.
2. Sign in when prompted, with Google or an email code. Your email must be on Gavin's list (see below).
3. Download `award-trip.zip` from this repo and upload it under Settings, Skills.
4. Connectors added on the web show up in the mobile app.

## Set up: Claude Code

```
/plugin marketplace add gcmead/awards
/plugin install awards@gcmead-awards
```

The plugin includes the skill and the connector. The first time you use it, sign in when asked.

## Link your seats.aero key

Create an API key on seats.aero (Settings, API), then paste it at
**https://awards.winemcp.com/settings/seats-aero** (sign in the same way). **Never paste the key
into chat.** If Claude says the key is missing or broken, ask it for the link (tool
`seats_key_link`) and replace the key there. `connections_status` shows whether the key is linked
and when it last worked.

## Recommended free connectors

Add these in Claude for better results (all optional; Claude says what is missing):

- **seats.aero** connector: near-term award search and live re-checks.
- **SlickTrip**: cash fares, schedules, seat maps.

## Tools

`connections_status`, `profile_get`, `profile_update`, `sweep`, `sweep_more`, `leg_details`,
`budget_status`, `transfer_paths`, `seats_key_link`, `itinerary_save`, `itinerary_list`,
`itinerary_get`, `itinerary_set_status`, `delete_my_data`, and `ping`. Claude calls these for you.

## Privacy

- Gavin runs the server. As operator he can technically read your profile, saved trips and usage
  counts in the database.
- Your seats.aero key is stored encrypted. The server has to decrypt it to make your searches, so
  it is not visible in normal operation, but this is not a promise that nobody could ever see it.
- No passwords are stored, and no airline or bank logins. Sign-in is through Cloudflare Access
  (Google or email code).
- The server calls no AI model.
- To remove your data, ask Claude to run `delete_my_data` (it will confirm first). That deletes
  your profile, saved trips, sweeps, cache and seats.aero key. It also signs you out everywhere, so
  reconnect afterwards.

## Getting access

Sign-in only works for emails Gavin has added. Ask Gavin to add your email.
