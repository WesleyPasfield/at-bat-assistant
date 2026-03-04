---
name: roster-strategy
description: >
  Use this skill for exploring a team's roster, finding player names, or understanding team composition.
  Triggered by "Who is on the [Team]?", "List the [Team] batters", or "Is [Player] on the [Team]?".
---

# Roster & Team Composition

## Tools
- `users__<your_schema>__get_team_batters`: Returns the full batter roster (Batters ONLY).
- `users__<your_schema>__lookup_player_by_name`: Verifies specific players.
- `genie_space_query`: Fallback for "Who are the pitchers for [Team]?" (since `get_team_batters` is batter-only).

## Workflow
1. **Identify Team**: Convert name to Abbreviation (e.g., "Mets" -> "NYM").

2. **Branch: Batter vs Pitcher**:
   - **IF Batters**: Call `get_team_batters`.
   - **IF Pitchers**: Call `genie_space_query` (Query: "Select distinct pitcher_name from pitches where team='NYM' and season_year=2024").

3. **Filter**: 
   - If the user asks "Who are the lefties?", filter the results locally or in the Genie query.

4. **Synthesize**:
   - Group by position if possible (Outfielders, Infielders) or simply list key players.

## Quality expectations
- **Completeness**: Don't list 40 players unless asked. List the starting 9 or key rotation pieces.
- **Accuracy**: Ensure the season year is correct. Rosters change fast.

## Response format
- **Headline**: "2024 New York Mets Roster (Key Batters)"
- **List**: Bulleted list.
- **Note**: "Data current as of 2024 season."

## Before Responding (Mandatory)
- [ ] I have used the correct Team Abbreviation.
- [ ] I have specified the season year clearly.
- [ ] I have not listed every minor leaguer; I focused on the active roster or key contributors.
- [ ] I have used Genie for pitcher rosters, not `get_team_batters`.