## Examples

### Example 1: Standard H2H
**User Query**: "How has Trout fared against Cole?"

**Tool Sequence**:
1. `parallel_tools`:
   - `users__<your_schema>__lookup_player_by_name(name_f='Mike', name_l='Trout')`
   - `users__<your_schema>__lookup_player_by_name(name_f='Gerrit', name_l='Cole')`
2. `parallel_tools`:
   - `users__<your_schema>__get_batter_pitcher_matchup(b_id=545361, p_id=543037, season_year=2024)`
   - `users__<your_schema>__get_batter_pitcher_matchup(b_id=545361, p_id=543037, season_year=2023)`

**Expected Response**:
"# Matchup History: Mike Trout vs Gerrit Cole (2023-2024)

In the last two seasons, they have faced each other 8 times:
- **Results**: 2 Hits (1 HR), 3 Strikeouts, 1 Walk.
- **Analysis**: Cole challenges Trout with high fastballs, generating 2 of the 3 strikeouts."

### Example 2: No History
**User Query**: "Soto vs Skenes history."

**Tool Sequence**:
1. `parallel_tools` -> Lookups.
2. `users__<your_schema>__get_batter_pitcher_matchup(...)`

**Expected Response**:
"I found no recorded matchups between Juan Soto and Paul Skenes in the 2024-2025 datasets. This is likely their first meeting."