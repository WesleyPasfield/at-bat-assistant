## Examples

### Example 1: Runner on First
**User Query**: "How does Glasnow pitch with a runner on first?"

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Tyler', name_l='Glasnow')`
2. `parallel_tools`:
   - `users__<your_schema>__get_pitcher_tendency_with_runners(p_id=607192, b_hand='R', b=0, s=0, p_on_1b=True, p_on_2b=False, p_on_3b=False, season_year=2025)`
   - `users__<your_schema>__get_pitcher_tendency_with_runners(p_id=607192, b_hand='L', b=0, s=0, p_on_1b=True, p_on_2b=False, p_on_3b=False, season_year=2025)`

**Expected Response**:
"# Tyler Glasnow with Runner on 1st

Aggregating data for both L and R batters:
- **Four-Seam Fastball**: 60% usage (N=85). Velocity holds steady at 97 MPH.
- **Curveball**: Usage drops to 20% (N=28) compared to his usual 30%.

Recommendation: Expect the heater. He simplifies his mix to control the running game."

### Example 2: Bases Loaded Pressure
**User Query**: "What does Hader throw with the bases loaded?"

**Tool Sequence**:
1. `users__<your_schema>__lookup_player_by_name(name_f='Josh', name_l='Hader')`
2. `users__<your_schema>__get_pitcher_tendency_with_runners(p_id=623352, b_hand='R', b=0, s=0, p_on_1b=True, p_on_2b=True, p_on_3b=True, season_year=2025)`

**Expected Response**:
"# Josh Hader - Bases Loaded (2025)

**Caution**: Extremely small sample size (N=12 pitches).
- **Sinker**: 83% usage (10/12). He relies almost exclusively on the fastball location.
- **Slider**: 17% usage (2/12).

Strategy: Do not look for the slider. He is challenging you with the fastball."