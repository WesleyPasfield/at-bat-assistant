## Gotchas

1. **NEVER** use `get_team_batters` for pitchers. It will return nothing or errors. Use Genie for pitcher rosters.
2. **MUST** handle "Who is the catcher?" queries by filtering the roster list, not just dumping the whole list.
3. **CRITICAL**: Team abbreviations are strict. If you use "NY" instead of "NYY" or "NYM", it will fail.
4. **DO NOT** assume a player is on a team without checking the year. Players trade often.