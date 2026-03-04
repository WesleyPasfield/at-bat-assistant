## Examples

### Example 1: Team Comparison
**User Query**: "Compare Yankees and Red Sox breaking ball usage in 2024."

**Tool Sequence**:
1. `genie_space_query(query="Select team, count(*) as total_pitches, sum(case when pitch_type in ('SL', 'CU', 'KC', 'ST') then 1 else 0 end) as breaking_balls from pitches where season_year=2024 and team in ('NYY', 'BOS') group by team")`
2. `sufficiency_eval(...)`

**Expected Response**:
"Based on 2024 data, the Yankees used breaking balls significantly more than the Red Sox:

**Yankees**: 21.7% (3,506 / 16,144)
**Red Sox**: 8.4% (1,875 / 22,414)

*Note: Breaking balls defined as Slider (SL), Curveball (CU), Knuckle Curve (KC), and Sweeper (ST).*"

### Example 2: League Leader
**User Query**: "Who had the highest barrel rate in 2024?"

**Tool Sequence**:
1. `genie_space_query(query="Select batter_name, barrel_rate, total_batted_balls from batting_stats where season_year=2024 and total_batted_balls > 100 order by barrel_rate desc limit 5")`
2. `sufficiency_eval(...)`

**Expected Response**:
"The leader in barrel rate for 2024 (min 100 batted balls) was **Aaron Judge**.

1. Aaron Judge: 26.5% (N=350)
2. Shohei Ohtani: 22.1% (N=400)
..."