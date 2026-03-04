---
name: h2h-matchups
description: >
  Use this skill for direct historical comparisons between a specific batter and pitcher.
  Triggered by "Has [Batter] faced [Pitcher]?", "[Batter] vs [Pitcher] stats", or "History between [Batter] and [Pitcher]".
---

# Head-to-Head Matchup History

## Tools
- `users__<your_schema>__lookup_player_by_name`: Resolve both Batter and Pitcher IDs.
- `users__<your_schema>__get_batter_pitcher_matchup`: Retrieves specific pitch-by-pitch history.
- `parallel_tools`: Execute lookups and multi-season queries efficiently.

## Workflow
1. **Identify Players**: Call `lookup_player_by_name` twice (once for batter, once for pitcher). Use `parallel_tools`.

2. **Fetch History**: Call `users__<your_schema>__get_batter_pitcher_matchup`.
   - **Season Iteration**: The tool requires `season_year`. If the user asks for "Career", you MUST iterate through the last 3 years (e.g., 2025, 2024, 2023) using `parallel_tools`.

3. **Analyze Results**:
   - The tool returns a list of *pitches*. You must aggregate them into *At-Bats*.
   - **Calculation Logic**: 
     - Count unique `at_bat_index` or similar grouping if available, OR count terminal events (Strikeout, Walk, InPlay).
     - Sum Hits, HRs, Ks, BBs.

4. **Fallback**:
   - IF no matchups found, explicitly state: "No recorded matchups found in the available dataset (2023-2025)."

## Quality expectations
- **Aggregation**: Do not just list every pitch. Summarize the outcome. "In 10 plate appearances, he has 3 hits and 4 strikeouts."
- **Sample Size Context**: "1 for 1" is not a trend. Label it as "Limited history".

## Response format
- **Summary**: "Over [N] plate appearances..."
- **Stats Box**: AVG | HR | K | BB
- **Detail**: "Notably, [Pitcher] strikes him out on Sliders."

## Before Responding (Mandatory)
- [ ] I have calculated the total Plate Appearances (PA) manually from the pitch list if not provided.
- [ ] I have checked for multiple seasons if the user asked for "History" or "Career".
- [ ] I have not invented stats (like Exit Velo) if the tool didn't return them.
- [ ] I have handled the case where 0 matchups exist gracefully.