# Kob Agent-Surface Cleanup

## Scope

Updated current agent-facing operational docs under `.agents/skills/kano/kano-agent-backlog-skill/` and the hook README to prefer supported `kob` flows instead of stale `kano-backlog` / Python-first guidance.

## Updated files

- `.agents/skills/kano/kano-agent-backlog-skill/CONTRIBUTING.md`
  - verification now uses `bash scripts/internal/show-version.sh`, `kob`, and `kob doctor`
  - backlog state-update examples now use the supported `workitem update-state <ID> --state ... --product ...` form

- `.agents/skills/kano/kano-agent-backlog-skill/docs/agent-quick-start.md`
  - install/verify flow now uses supported `kob` and version-helper commands
  - backlog state/ready examples now use `workitem set-ready` and `workitem update-state`
  - Windows troubleshooting now prefers the repo-local `kob` launcher and native build flow over Python-first fallback guidance

- `.agents/skills/kano/kano-agent-backlog-skill/.githooks/README.md`
  - commit and worklog examples now use `kob`

## Verification

- `bash kob`
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`
- post-cleanup scan confirms no stale `kano-backlog` command examples remain in the updated files apart from intentional historical/package-name references

## Notes

- Historical/package-name text such as `kano-agent-backlog-skill` remains unchanged where it refers to the package or project name, not the local command surface.
