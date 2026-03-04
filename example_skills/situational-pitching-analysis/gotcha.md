## Gotchas

1. **NEVER** ignore the count parameters in `get_pitcher_tendency_with_runners`. If the tool requires `b` and `s`, and the user didn't specify, you MUST assume 0-0 or run multiple queries. Do not pass `null`.
2. **CRITICAL**: "Runners in Scoring Position" (RISP) is a concept, not a tool parameter. You MUST query for Runner on 2nd AND Runner on 3rd separately/together and aggregate. If you only query `p_on_2b=True`, you are missing data.
3. **DO NOT** hallucinate velocity drops. Only state that velocity decreased if the data explicitly shows a lower `release_speed` compared to his bases-empty average.
4. **MUST** handle zero results. Situational splits are rare. If the tool returns nothing, state "No data available for this specific base state in 2025."