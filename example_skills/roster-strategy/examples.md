## Examples

### Example 1: Team Batters
**User Query**: "Who hits for the Orioles?"

**Tool Sequence**:
1. `users__<your_schema>__get_team_batters(team_abbr='BAL', season_year=2024)`

**Expected Response**:
"Here are the key batters for the 2024 Baltimore Orioles:
- **Gunnar Henderson**
- **Adley Rutschman**
- **Anthony Santander**
..."

### Example 2: Pitching Staff (Genie Fallback)
**User Query**: "List the Braves starting rotation."

**Tool Sequence**:
1. `genie_space_query(query="Select distinct pitcher_name from pitches where team='ATL' and season_year=2024 and role='SP' limit 10")`
2. `sufficiency_eval(...)`

**Expected Response**:
"The projected starting rotation for the Atlanta Braves in 2024 includes:
- Spencer Strider
- Max Fried
- Chris Sale
..."