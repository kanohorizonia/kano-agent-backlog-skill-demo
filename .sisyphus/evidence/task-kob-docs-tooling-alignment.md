# Kob Docs Tooling Alignment

## Scope

Aligned the current docs preparation script and prerequisite helper so they prefer the supported repo-local `kob` command surface instead of older `kano-backlog` probing and labeling.

## Updated files

- `scripts/docs/02-prepare-content.sh`
  - now probes repo-local `kob` first, then PATH `kob`
  - generated CLI commands page is labeled `kob`
  - CLI content is captured from `kob` usage output rather than the old `kano-backlog --help` path

- `scripts/prerequisite.sh`
  - install verification now checks for `kob` only
  - next-step messaging stays aligned with the repo-local native flow

## Verification

- `bash kob`
- `bash kob doctor`
- `bash script/test`
- static inspection confirms docs tooling now generates/labels the CLI page around `kob`
