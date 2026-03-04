## Gotchas

1. **NEVER** run `pitcher_embedding_lookup` without first checking the arsenal. If you ask for a Sinker embedding for a pitcher who doesn't throw one, the tool will fail or return garbage.
2. **MUST** clarify that similarity is mathematical (vector distance). A "similar" pitcher might have the same velocity/movement but different results (ERA). Don't conflate "stuff" with "success".
3. **CRITICAL**: Handle special characters in names. If `lookup_player_by_name` fails for "Acuna", try "Acuña". The tool might be sensitive.
4. **NEVER** output the raw embedding vector values as physical stats. Seeing "Velocity: 0.86" confuses users. Convert it or describe it qualitatively ("High Velocity").