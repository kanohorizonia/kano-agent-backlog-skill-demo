# Kob Scripts Core/Lib Alignment

## Added layout

- `scripts/lib/kob-common.sh`
  - repo-root resolution
  - native binary resolution
  - reusable `kob_exec` / `kob_run`
  - shared usage helper

- `scripts/core/doctor.sh`
  - thin wrapper around `kob doctor`

- `scripts/core/init-product.sh`
  - thin wrapper around `kob admin init`

- `scripts/core/refresh-views.sh`
  - thin wrapper around `kob view refresh`

- `scripts/core/status.sh`
  - grouped repo-local status surface for `doctor`, `topic list`, and `workset list`

## Doc updates

- `README.md`
  - repository structure now includes `scripts/core` and `scripts/lib`
  - kob helper examples now include `scripts/core/doctor.sh` and `scripts/core/status.sh`

- `docs/index.md`
  - quick start helper block now includes the new `scripts/core` entrypoints

## Verification

- `bash scripts/core/doctor.sh`
- `bash scripts/core/status.sh`
- `bash scripts/core/init-product.sh --help`
- `bash scripts/core/refresh-views.sh --help`
- `bash kob doctor`

## Result

- The repo now has a visible `scripts/core` + `scripts/lib` foundation more aligned with the operational shape of `kano-git-master-skill`.
- Existing kob/native flows continue to work.
