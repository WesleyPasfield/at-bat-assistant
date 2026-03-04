---
name: league-analysis-genie
description: >
  Use this skill for broad league-wide questions, team comparisons, or specific metric aggregations
  that are NOT covered by specific pitcher/batter tools. 
  Triggered by "League average for...", "Compare Yankees and Red Sox", "Who has the highest...",
  or "Team stats".
---

# League & Team Analysis (Genie Fallback)

## Tools
- `genie_space_query`: The primary engine for SQL-like natural language queries.
- `sufficiency_eval`: Checks if the Genie result answers the user's question.

## Workflow
1. **Formulate Query**: Convert the user's request into a precise natural language query.
   - **Team Aggregates**: IF the user asks for a team stat (e.g., "Astros Fastball %"), you MUST structure the query to retrieve individual player data (e.g., "Select player_name, usage... where team='HOU'") so you can display the breakdown. Do NOT just ask for the team average unless explicitly requested.
   - **Filters**: Be explicit about `season_year` (default to 2025).

2. **Execute Genie**: Call `genie_space_query`.

3. **Evaluate**: Call `sufficiency_eval` on the result.
   - **IF Insufficient**: Reformulate the query (e.g., simplify constraints) and retry.

4. **Post-Process**:
   - **Breakdown**: If you retrieved team data, list the top 3-5 contributors in your response.
   - **Sanity Check**: Verify rates (e.g., Barrel Rate should be ~5-15%, not 50%). If data looks wrong, flag it.

## Quality expectations
- **Definitions**: If aggregating "Offspeed" or "Breaking Balls", you MUST list what pitch types were included in the query or result.
- **Raw Values**: Ensure units are clear. MPH for velocity, Degrees for angle.
- **Team vs Individual**: "Astros Pitchers" implies a list of pitchers, not just one number. Users want to know *who* on the team is doing what.

## Response format
- **Summary**: "The league average spin rate is 2,250 RPM."
- **Breakdown**: Table or list showing the top N results or the specific comparison requested.
- **Context**: "This places [Player] in the 90th percentile."

## Before Responding (Mandatory)
- [ ] I have defined any aggregated terms like "Breaking Ball" or "Offspeed".
- [ ] I have provided the specific N (count) for any rate stats (e.g., "20% (500/2500)").
- [ ] If the user asked for a team stat, I have broken it down by individual leaders (e.g., "Top 3 Pitchers on the team").
- [ ] I have sanity-checked the numbers (e.g., Barrel Rate < 20%).