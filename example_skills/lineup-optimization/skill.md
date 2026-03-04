---
name: lineup-optimization
description: >
  Use this skill for questions about team strategy, lineup construction, or identifying best batters against a pitcher.
  Triggered by "Who should bat against [Pitcher]?", "Best lineup vs [Pitcher]", or "Which [Team] batters hit [Pitcher] well?".
---

# Lineup Optimization & Matchup Recommendations

## Tools
- `users__<your_schema>__lookup_player_by_name`: Identify the opposing pitcher.
- `users__<your_schema>__get_team_batters`: Get the full roster for the batting team.
- `users__<your_schema>__recommend_batter_matchups_by_team`: The core ranking engine.
- `users__<your_schema>__batter_embeddings_for_ids`: Retrieves detailed metrics for specific batters to explain the "Why".
- `users__<your_schema>__get_batter_pitcher_matchup`: Fallback for specific history.

## Workflow
1. **Identify Entities**: Lookup the Pitcher ID and identify the Team Abbreviation (e.g., "Phillies" -> "PHI").

2. **Get Recommendations**: Call `recommend_batter_matchups_by_team`.
   - This returns a weighted expected wOBA list.
   - **IF Empty**: The tool might lack data (early season). **Fallback**: Call `get_team_batters`, then iterate `get_batter_pitcher_matchup` for the top 5 batters to find history.

3. **Deep Dive (The 'Why')**:
   - Select the top 3 recommended batters.
   - Call `users__<your_schema>__batter_embeddings_for_ids` for these IDs.
   - Use this data to explain *why* they are good picks (e.g., "High barrel rate vs Fastballs").

4. **Filter & Sort**: 
   - Sort the results by the metric provided (usually expected wOBA).
   - Select the top 5-9 batters to form a "lineup".

## Quality expectations
- **Actionable**: Don't just list names. Provide the projected metric (e.g., "Expected wOBA: .450").
- **Explanation**: Use the embedding data to give a physical reason for the recommendation.

## Response format
- **Headline**: "Recommended Lineup vs [Pitcher]"
- **List**: Ordered list of batters with their rating/score.
- **Analysis**: "This lineup prioritizes left-handed hitters who handle high velocity, targeting [Pitcher]'s weakness."

## Before Responding (Mandatory)
- [ ] I have listed at least 5 batters if asking for a lineup.
- [ ] I have explained the metric used for ranking (e.g., "Ranked by expected wOBA").
- [ ] I have confirmed the team abbreviation matches the user's request (e.g., NYY vs NYM).
- [ ] I have provided a "Why" for the top picks using embedding/stats data.