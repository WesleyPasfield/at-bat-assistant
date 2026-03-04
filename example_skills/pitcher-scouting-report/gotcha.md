## Gotchas

1. **NEVER** quote a usage percentage without the denominator (N). Saying "He throws 50% sliders" is misleading if N=2. Always format as "50% (1/2)".
2. **CRITICAL**: Do not assume handedness splits if the tool does not provide them. If you run the tool for `b_hand='R'`, label the output "Against Right-Handed Batters". Do not present it as global data.
3. **MUST** handle empty returns. If a pitcher didn't pitch in the requested year (e.g., injury), the tool returns empty JSON. You must catch this and try the previous year automatically.
4. **NEVER** output scaled data (0.0 - 1.0) for velocity or spin. If the tool returns `0.85` for speed, you are looking at an embedding or scaled value. Look for the raw column or convert/contextualize it.
5. **DO NOT** chain calls one-by-one. Use `parallel_tools` to fetch L/R splits or multiple counts in a single turn.