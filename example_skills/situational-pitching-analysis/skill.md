---
name: situational-pitching-analysis
description: >
  Use this skill for queries about specific game states involving runners on base.
  Triggered by "runners in scoring position", "runner on 1st", "bases loaded",
  or "how does he pitch from the stretch?".
---

# Situational Pitching Analysis

## Tools
- `users__<your_schema>__lookup_player_by_name`: Resolves pitcher ID.
- `users__<your_schema>__get_pitcher_tendency_with_runners`: The primary tool for runner-state queries.
- `parallel_tools`: Required for aggregating complex states like RISP.

## Workflow
1. **Identify Pitcher**: Call `lookup_player_by_name`.

2. **Define Scenario & Execute**:
   - **Scenario A: Specific Base** (e.g., "Runner on 1st"): Call `get_pitcher_tendency_with_runners` with `p_on_1b=True`, others `False`.
   - **Scenario B: RISP (Runners in Scoring Position)**: This is NOT a single flag. You MUST use `parallel_tools` to query THREE states:
     - Runner on 2nd (`p_on_2b=True`, others False)
     - Runner on 3rd (`p_on_3b=True`, others False)
     - Runners on 2nd & 3rd (`p_on_2b=True`, `p_on_3b=True`)
   - **Scenario C: Bases Loaded**: Set all flags to `True`.

3. **Synthesize Data**:
   - **Aggregation**: If running a RISP query, sum the pitch counts from the parallel results to create a "Total RISP" profile. Do NOT average the averages. Sum the numerators and denominators.
   - **Comparison**: Compare the velocity in these states to the pitcher's typical velocity (if known) to identify "stretch" fatigue.

4. **Fallback**:
   - **Low Sample Size**: If the total N < 15, you MUST prepend a warning: "**Caution: Very small sample size (N=XX). Data may not be predictive.**"

## Quality expectations
- **Contextual Accuracy**: Ensure the boolean flags strictly match the user's request.
- **Aggregation**: Do not list 3 separate tables for RISP. Combine them into one "RISP Summary" unless the user asks for splits.
- **Raw Values**: Always provide MPH/RPM.

## Response format
- **Scenario**: "## Situation: Runners in Scoring Position (RISP)"
- **Sample Warning**: (If applicable)
- **Pitch Mix Table**: Pitch Type | Usage % | Velocity | Count (N)
- **Insight**: "He abandons the curveball with runners on, relying heavily on the slide-step fastball."

## Before Responding (Mandatory)
- [ ] I have confirmed the runner configuration matches the user's query exactly (e.g., RISP covers 2B and 3B).
- [ ] I have included a sample size warning if the total pitches analyzed is low (< 20).
- [ ] I have provided raw velocity values (MPH), not just scaled numbers.
- [ ] I have aggregated parallel query results into a single summary if the user asked for a general state like RISP.