---
name: pitcher-scouting-report
description: >
  Use this skill for analyzing a pitcher's arsenal, velocity, usage patterns, and tendencies by count or handedness.
  Triggered by "What does [Pitcher] throw?", "How does [Pitcher] attack lefties?", "[Pitcher] scouting report",
  or "Velocity check for [Pitcher]".
---

# Pitcher Scouting Report & Arsenal Analysis

## Tools
- `users__<your_schema>__lookup_player_by_name`: Resolves player names to IDs (Mandatory first step).
- `users__<your_schema>__pitcher_arsenal_lookup`: Retrieves the full list of pitch types thrown.
- `users__<your_schema>__get_pitcher_tendency_by_count`: Retrieves usage/location data split by count and batter hand.
- `parallel_tools`: Executes multiple tendency queries simultaneously for efficiency.

## Workflow
1. **Identify Player**: Call `lookup_player_by_name`.
   - **IF lookup fails**: Retry with name variations (e.g., "Acuña" -> "Acuna"). IF still fails, ask user for clarification.

2. **Get Arsenal**: Call `users__<your_schema>__pitcher_arsenal_lookup`.
   - **Critical Check**: Review the returned pitch types. If the user asks about a pitch NOT in this list (e.g., "How is his splitter?" but he throws none), stop and inform the user.

3. **Determine Analysis Scope**:
   - **Scenario A: Specific Context** (e.g., "vs Lefties on 0-2"): Call `get_pitcher_tendency_by_count` with specific `b_hand`, `b`, and `s` params.
   - **Scenario B: General Overview**: You MUST build a representative sample. Use `parallel_tools` to call `get_pitcher_tendency_by_count` for:
     - `b=0, s=0` (First Pitch)
     - `b=1, s=1` (Even Count)
     - `b=0, s=2` (Putaway Count)
     - **Split**: Run these for BOTH `b_hand='L'` and `b_hand='R'` unless the user specified one.

4. **Process Data**:
   - **Aggregation**: Calculate weighted averages for usage/velocity across the returned counts to estimate "overall" stats if a general report was requested.
   - **Physics Validation**: Check the velocity hierarchy. Fastball > Slider > Curve. If Sinker > Fastball by >5 MPH, flag as a data anomaly.
   - **Scaling Check**: If velocity is < 1.0 (e.g., 0.85), it is SCALED. DO NOT OUTPUT IT. State "Velocity data unavailable" or use `genie_space_query` to get raw MPH.

5. **Fallback Strategy**:
   - **IF 2025 data is empty**: Automatically retry with `season_year=2024`. Explicitly state: "2025 data unavailable; showing 2024 analysis."

## Quality expectations
- **Sample Sizes**: Every percentage MUST have a denominator (N). "45% usage (N=90)".
- **Granularity**: Break down "Breaking Balls" into specific types (Slider, Curve, Sweeper).
- **Units**: Always use MPH for velocity and RPM for spin. NEVER output 0-1 scaled values.

## Response format
- **Data Source**: "Based on [Year] data for [Pitcher]..."
- **Arsenal Overview**: Bullet points with Pitch Type | Velocity (MPH) | Usage % (N).
- **Strategic Breakdown**: "vs Lefties: Attacks with Fastball up..." / "vs Righties: Sweeper away..."
- **Recommendation**: "Hitter approach: Sit fastball early, protect outer half with 2 strikes."

## Before Responding (Mandatory)
- [ ] I have included the raw count (N) for every percentage cited (e.g., "45% (90/200)").
- [ ] I have explicitly listed which pitch types are in any aggregate category (e.g., "Breaking Balls: SL, CU").
- [ ] I have verified that all velocities are in MPH (e.g., 95.2) and NOT scaled values (e.g., 0.8).
- [ ] If I switched seasons (e.g., 2025 -> 2024), I have explicitly stated this in the output.