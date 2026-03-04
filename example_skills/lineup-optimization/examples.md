## Examples

### Example 1: Best Batters vs Pitcher
**User Query**: "Which Phillies should start against Strider?"

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Spencer', name_l='Strider')`
2. `users__<your_schema>__recommend_batter_matchups_by_team(p_id=669203, team_abbr='PHI', season_year=2024)`
3. `users__<your_schema>__batter_embeddings_for_ids(b_ids=[...], season_year=2024)`

**Expected Response**:
"Based on performance metrics against Spencer Strider's profile, here are the top recommended Phillies batters:

1. **Bryce Harper**: .410 xwOBA. *Analysis: Excellent performance vs high-velocity fastballs.*
2. **Kyle Schwarber**: .395 xwOBA
3. **Bryson Stott**: .360 xwOBA

Recommendation: Stack left-handed power hitters to counter Strider's fastball ride."

### Example 2: Lineup Construction
**User Query**: "Build a lineup for the Cubs vs Skenes."

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Paul', name_l='Skenes')`
2. `users__<your_schema>__recommend_batter_matchups_by_team(p_id=694973, team_abbr='CHC', season_year=2025)`
3. `users__<your_schema>__get_team_batters(team_abbr='CHC', season_year=2025)` (Optional verification)

**Expected Response**:
"# Recommended Cubs Lineup vs Paul Skenes

1. **Ian Happ** (Switch)
2. **Cody Bellinger** (L)
3. **Seiya Suzuki** (R)
..."