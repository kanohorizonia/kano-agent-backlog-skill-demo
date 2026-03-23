# Kob Canonical Skill-Surface Cleanup

## Scope

Updated the highest-visibility current canonical skill docs to prefer supported `kob` flows instead of stale `kano-backlog` verification and setup guidance.

## Updated files

- `.agents/skills/kano/kano-agent-backlog-skill/README.md`
  - quick install and minimal usage now prefer `kob` and `workitem` forms where applicable

- `.agents/skills/kano/kano-agent-backlog-skill/docs/SETUP_SUMMARY.md`
  - setup and verification now use `bash scripts/internal/show-version.sh`, `kob`, and `kob doctor`

- `.agents/skills/kano/kano-agent-backlog-skill/docs/release-checklist.md`
  - release verification checks now reference `kob` and the version helper

- `.agents/skills/kano/kano-agent-backlog-skill/SKILL.md`
  - top bootstrap guidance now points to `kob` for current local flows
  - file-operation guidance now references the supported local CLI surface instead of Python-first invocation text in the highest-visibility sections

## Verification

- `bash kob`
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`
- scan confirms the in-scope canonical docs no longer use stale top-surface `kano-backlog` verification examples

## Notes

- Deep archival/reference sections inside `SKILL.md` still contain older examples and can be modernized in a future focused pass.
- This pass intentionally targeted the highest-visibility current guidance first.
