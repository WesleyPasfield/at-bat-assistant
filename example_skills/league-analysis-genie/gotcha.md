## Gotchas

1. **NEVER** return a raw SQL error or "I don't know" without trying to simplify the query first. Genie might fail on complex joins but succeed on simple selects.
2. **CRITICAL**: Watch out for "Average" vs "Total". If the user asks for "Most Home Runs", do not give the average. If they ask for "Average Velocity", do not sum them.
3. **MUST** verify data physics. If Genie returns an average fastball velocity of 10 MPH, the unit is wrong or the data is bad. Do not output it blindly. Flag it.
4. **NEVER** provide a single aggregate number for a team (e.g., "Phillies: 95 MPH") without also listing the key players who drive that number. Users need actionable granularity.
5. **DO NOT** hallucinate splits (e.g., "vs Lefties") if Genie didn't explicitly return that column. If the query didn't group by handedness, the result is global.