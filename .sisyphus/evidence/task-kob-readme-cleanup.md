# Kob README Cleanup

## Scope

Cleaned the remaining README command-style reference that still used `kano-backlog` for the local `topic distill` example.

## Result

- README local workflow examples now consistently use `kob`.
- Remaining `kano-backlog` text in README is limited to project/package naming, not the primary local command surface.

## Verification

- `bash kob`
- `bash kob doctor`
- README scan confirms no remaining local command examples use `kano-backlog`
