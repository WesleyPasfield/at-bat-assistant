## Examples

### Example 1: Pitcher Comp
**User Query**: "Who has a slider like Sale?"

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Chris', name_l='Sale')`
2. `users__<your_schema>__pitcher_arsenal_lookup(p_id=519242)`
3. `users__<your_schema>__pitcher_embedding_lookup(p_id=519242, season_year=2024, p_type='SL')`
4. `users__<your_schema>__pitcher_embedding_query(e_vector=[...])`

**Expected Response**:
"Based on 2024 movement and release metrics, the pitchers with the most similar Slider to **Chris Sale** are:

1. **Josh Hader**: Similar arm angle and sweeping action.
2. **Matt Strahm**
3. **Andrew Miller** (Historical comp)

These pitchers share Sale's low release height and high horizontal break."

### Example 2: Batter Comp
**User Query**: "Find batters similar to Ohtani."

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Shohei', name_l='Ohtani')`
2. `users__<your_schema>__batter_embedding_lookup(p_id=660271, season_year=2024, p_type='FF')` (Looking for similarity vs Fastballs)
3. `users__<your_schema>__batter_embedding_query(e_vector=[...])`

**Expected Response**:
"Batters with a similar performance profile against Fastballs as Shohei Ohtani:
1. **Yordan Alvarez**
2. **Aaron Judge**
..."