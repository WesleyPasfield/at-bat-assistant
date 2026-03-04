---
name: similar-player-finder
description: >
  Use this skill to find player comparisons (comps) based on physical characteristics, arsenal, or performance metrics.
  Triggered by "Who pitches like [Player]?", "Find similar batters to [Player]", or "Comps for [Player]".
---

# Similar Player Finder

## Tools
- `users__<your_schema>__lookup_player_by_name`: ID resolution.
- `users__<your_schema>__pitcher_arsenal_lookup`: Needed to get pitch types for the embedding lookup.
- `users__<your_schema>__pitcher_embedding_lookup` / `query`: For pitcher comps.
- `users__<your_schema>__batter_embedding_lookup` / `query`: For batter comps.

## Workflow
1. **Identify Subject**: Call `lookup_player_by_name`.

2. **Branch: Pitcher vs Batter**:
   - **IF Pitcher**:
     a. Call `pitcher_arsenal_lookup` to see what they throw.
     b. Select the *primary* pitch or the specific pitch requested (e.g., "Who has a similar Slider?"). **Check**: Does the pitcher actually throw this pitch? If not, abort.
     c. Call `pitcher_embedding_lookup` for that pitch type.
     d. Call `pitcher_embedding_query` with the returned vector.
   - **IF Batter**:
     a. Call `batter_embedding_lookup` (usually for 'All' or specific pitch type performance).
     b. Call `batter_embedding_query`.

3. **Synthesize**:
   - Present the top 3-5 matches.
   - **Crucial**: Explain *why* they are similar. "Similar release point and velocity band."
   - **Data Handling**: The embedding vectors are scaled (0-1). **NEVER** display these as raw stats. Use them only to calculate similarity or describe relative traits (e.g., "High extension").

4. **Stats Fallback**:
   - IF the user asks for the stats of the similar players (e.g., "What is their velocity?"), you MUST run a *new* query (e.g., `pitcher_arsenal_lookup` or `genie_space_query`) for those specific players. Do NOT use the embedding numbers.

## Quality expectations
- **Context**: Similarity is usually specific to a pitch type. "Similar Fastball" is different from "Similar overall pitcher". Be specific.
- **Scaled Data**: Embeddings often return scaled values (0-1). Do NOT present these as raw stats.

## Response format
- **Subject**: "Analyzing comps for Spencer Strider's Fastball..."
- **Matches**: List of players.
- **Similarity Score**: If available (distance).
- **Commentary**: "These pitchers all share high ride and extension."

## Before Responding (Mandatory)
- [ ] I have specified WHICH pitch type is being compared (e.g., "Comparing Sliders").
- [ ] I have NOT presented scaled embedding vectors (0.8) as raw velocity (95 MPH).
- [ ] I have listed at least 3 comparable players.
- [ ] I have explained the physical reasons for similarity (e.g., "Arm angle", "Movement").