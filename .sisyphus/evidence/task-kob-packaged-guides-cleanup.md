# Kob Packaged Guides Cleanup

## Scope

Updated the packaged canonical usage guides under `.agents/skills/kano/kano-agent-backlog-skill/docs/` so they prefer the current `kob` command surface and avoid stale command forms in active guidance.

## Updated files

- `.agents/skills/kano/kano-agent-backlog-skill/docs/topic.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/workset.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/usage-examples.md`

## Key fixes

- rebranded current command examples from `kano-backlog` to `kob`
- normalized stale forms such as:
  - `item set-ready` -> `workitem set-ready`
  - `item update-state` -> `workitem update-state`
  - `item show` -> `workitem read`
  - `admin adr create` -> `adr create`
  - `worklog add` -> `worklog append`
- corrected one stale ADR reference in `workset.md`

## Verification

- static scans confirm the targeted packaged guides no longer contain the stale forms above
- `bash kob`
- `bash kob doctor`

## Notes

- This pass targeted active packaged guidance, not historical release/reference artifacts.
