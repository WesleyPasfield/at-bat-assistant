# Original Judge

        "Evaluate if the response in {{ outputs }} appropriately analyzes the available data and provides an actionable recommendation "
        "to the question in {{ inputs }}. The response should be accurate, contextually relevant, and give a strategic advantage to the "
        "hitter or coaching staff making the request. "
        "Your grading criteria should be: "
        " 1: Completely unacceptable. Incorrect data interpretation or no recommendations"
        " 2: Mostly unacceptable. Irrelevant or spurious feedback or weak recommendations provided with minimal strategic advantage"
        " 3: Somewhat acceptable. Relevant feedback provided with some strategic advantage"
        " 4: Mostly acceptable. Relevant feedback provided with strong strategic advantage"
        " 5: Completely acceptable. Relevant feedback provided with excellent strategic advantage"

# Aligned Judge 

--- Aligned Judge Guidelines ---

1. Always include the total number of pitches thrown alongside usage rates or percentages.

2. When presenting scaled or normalized data (e.g., exit velocity, launch angle), always provide the raw values (e.g., MPH, degrees) if possible, or explicitly clarify the unit of measurement.

3. Aggregate statistics should be broken down by individual player when the user asks for a team-wide distribution (e.g., pitch types for a pitching staff).

4. Verify data accuracy against general baseball knowledge (e.g., barrel rates are typically 5-10%, not 50%+).

5. Do not present data split by handedness or other categories if the data source did not explicitly provide that breakdown (avoid hallucinating splits).

6. When analyzing pitch arsenals or usage, explicitly define which specific pitch types are included in broader categories like 'breaking balls'.

7. Optimize tool usage by avoiding unnecessary queries for data that can be logically inferred (e.g., teammates don't face each other, recent roster lists don't need complex embeddings).

8. When providing recommendations (e.g., optimal lineups), explain the 'why' behind the choice, such as specific weaknesses or matchup advantages.

9. Ensure robustness in entity recognition, handling special characters (e.g., 'ñ') correctly to avoid lookup failures.

10. When comparing similar players or arsenals, include frequency/usage percentages, not just the existence of pitch types or physical characteristics.

11. Sanity check velocity data to ensure pitch types follow expected physics (e.g., sinkers shouldn't be significantly faster than four-seam fastballs if that contradicts the player's known profile).

12. Ensure data availability checks are accurate regarding player activity (e.g., acknowledging a player pitched in a specific season if they did).

13. When listing a pitch arsenal, include the distribution/usage percentage of each pitch type, not just a list of names.

--- Episodic Memory (30 examples) ---

### Episodic Memory (Representative Examples) - cut to 4 for space reasons

Example 1:
  Input: <bound method Example.inputs of Example({'result': '4.0', 'rationale': 'I want to see the number of pitches thrown too', 'inputs': "{'request': {'tool_choice': None, 'truncation': None, 'max_output_to
  Output: Based on the available data, **Kyle Hurt** of the Los Angeles Dodgers had the highest changeup usage rate in the National League in 2024 at **52.2%**.
  Rationale: I want to see the number of pitches thrown too

Example 2:
  Input: <bound method Example.inputs of Example({'result': '3.0', 'rationale': 'I want to also see the raw values even if the scaled data used for analysis', 'inputs': "{'request': {'tool_choice': None, 'trun
  Output: Now I'll analyze the exit velocity data from the embeddings. The first value in each embedding vector represents launch_speed (exit velocity), which is minmax scaled between 0 and 1. Let me calculate 
  Rationale: I want to also see the raw values even if the scaled data used for analysis

Example 3:
  Input: <bound method Example.inputs of Example({'result': '5.0', 'rationale': '', 'inputs': "{'request': {'tool_choice': None, 'truncation': None, 'max_output_tokens': None, 'metadata': None, 'parallel_tool_
  Output: Based on the available data, Guardians pitchers threw **43.55%** of their pitches in the upper third of the zone in 2024.
  Rationale: 

Example 4:
  Input: <bound method Example.inputs of Example({'result': '2.0', 'rationale': 'This should be interpreted to show each individual on the team not across the whole team aggregated', 'inputs': "{'request': {'t
  Output: # Phillies 2024 Pitching Staff - Pitch Type Distribution

Here's the pitch type distribution for the entire Phillies pitching staff in 2024:

| Pitch Type | Count | Percentage |
|------------|-------|
  Rationale: This should be interpreted to show each individual on the team not across the whole team aggregated


....

