# Kob SKILL Deep-Guidance Cleanup

## Scope

Updated deeper current-guidance sections of the canonical `SKILL.md` so they prefer supported `kob` and current repo-local flows instead of stale Python-first or old `kano-backlog` invocation patterns.

## Updated areas

- container/bootstrap examples
- sequence sync and ID-conflict guidance
- semantic search and index maintenance examples
- profile/help-driven discovery sections
- canonical examples block
- sandbox/state helper guidance
- topic lifecycle and workset lifecycle sections
- profile examples and topic-state inspection examples

## Verification

- static scan confirms the targeted stale deep-guidance forms were removed from the updated `SKILL.md`
- `bash kob`
- `bash kob doctor`
- `bash scripts/core/status.sh`

## Notes

- This pass targeted active operational guidance, not every historical/reference mention across the whole skill package.
