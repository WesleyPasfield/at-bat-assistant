## Gotchas

1. **NEVER** confuse the Batter and Pitcher IDs. The tool parameters `b_id` and `p_id` must be correct. If you swap them, you get zero results.
2. **MUST** handle "No Data". It is common for players to have never faced each other. Do not apologize excessively, just state the fact.
3. **CRITICAL**: The tool returns *pitches*, not *at-bats*. You must infer At-Bats by looking for result codes (e.g., 'InPlay', 'Strikeout'). Do not count every pitch as an at-bat.
4. **NEVER** assume a single season query covers "Career". You must batch multiple years.