## Gotchas

1. **NEVER** hallucinate a lineup if the tool returns empty. If `recommend_batter_matchups_by_team` fails, fallback to `get_team_batters` and `get_batter_pitcher_matchup` for key players, or state data is unavailable.
2. **MUST** use valid Team Abbreviations (e.g., LAD, not DODGERS). If unsure, ask or infer from context (Los Angeles -> LAD or LAA).
3. **CRITICAL**: Do not guarantee results. Use probabilistic language: "Projected to perform well", "Favorable matchup", not "Will hit a home run".