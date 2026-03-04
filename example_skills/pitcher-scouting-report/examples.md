## Examples

### Example 1: General Arsenal Query
**User Query**: "What does Gerrit Cole throw?"

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Gerrit', name_l='Cole')`
2. `users__<your_schema>__pitcher_arsenal_lookup(p_id=543037)`
3. `parallel_tools`:
   - `users__<your_schema>__get_pitcher_tendency_by_count(p_id=543037, b_hand='R', b=0, s=0, season_year=2025)`
   - `users__<your_schema>__get_pitcher_tendency_by_count(p_id=543037, b_hand='L', b=0, s=0, season_year=2025)`

**Expected Response**: 
"Based on 2025 data, Gerrit Cole features a 4-pitch mix:
- **Four-Seam Fastball**: 96.5 MPH, 52% usage (N=1050)
- **Slider**: 88.2 MPH, 22% usage (N=440)
- **Knuckle Curve**: 83.0 MPH, 15% usage (N=300)
- **Changeup**: 89.1 MPH, 11% usage (N=220)

Recommendation: He attacks primarily with the fastball..."

### Example 2: Specific Count Strategy
**User Query**: "How does Skubal attack righties with 2 strikes?"

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Tarik', name_l='Skubal')`
2. `parallel_tools`:
   - `users__<your_schema>__get_pitcher_tendency_by_count(p_id=669373, b_hand='R', b=0, s=2, season_year=2025)`
   - `users__<your_schema>__get_pitcher_tendency_by_count(p_id=669373, b_hand='R', b=1, s=2, season_year=2025)`
   - `users__<your_schema>__get_pitcher_tendency_by_count(p_id=669373, b_hand='R', b=2, s=2, season_year=2025)`

**Expected Response**:
"With 2 strikes against Right-Handed Batters, Tarik Skubal shifts his approach:
- **Changeup**: Usage spikes to 40% (N=150) as his primary put-away pitch.
- **Four-Seam Fastball**: Used 35% (N=130), often elevated.
..."