# Kob Usage Examples Alignment

## Scope

Corrected `docs/usage-examples.md` so its command examples match the current native `kob` CLI surface instead of older, unsupported subcommands.

## Key fixes

- `kob admin validate structure` -> `kob validate repo-layout`
- `kob admin adr create` -> `kob adr create`
- `kob item set-ready` -> `kob workitem set-ready`
- `kob item update-state` -> `kob workitem update-state`
- `kob item show` -> `kob workitem read`
- unsupported `view report` / `view export` examples replaced with supported inspection flows
- command discovery section updated to supported `kob` and wrapper-help flows

## Verification

- `bash kob`
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`
- `bash scripts/core/status.sh`
- scan confirms the stale command forms were removed from `docs/usage-examples.md`

## Notes

- Some examples still use `item create` / `item list`, which remain part of the currently documented native/local surface.
- Remaining `--agent` flags in the file are attached to still-supported commands such as `adr create`, `worklog append`, and `topic create/switch`.
