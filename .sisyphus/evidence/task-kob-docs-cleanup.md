# Kob Docs Cleanup

## Scope

Updated the primary docs pages that describe current repo-local workflows so they prefer `kob` instead of `kano-backlog`.

## Updated files

- `docs/configuration.md`
  - local command examples now use `kob`

- `docs/installation.md`
  - local verification examples now use supported `kob` and `scripts/internal/show-version.sh` flows
  - removed unsupported `kob --version` guidance

- `docs/orphan-commit-detection.md`
  - current command examples now use `kob`

## Preserved historical/reference material

- benchmark and release-history documents were left alone when they represent recorded historical command invocations rather than current repo-local guidance

## Verification

- `bash kob`
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`
- in-scope doc scan shows no remaining `kano-backlog` command examples in the updated files
