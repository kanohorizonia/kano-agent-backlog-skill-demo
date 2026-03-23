# Kob Create/Update Wrapper Expansion

## Added scripts/core wrappers

- `scripts/core/create-workitem.sh`
  - thin wrapper for `kob item create`

- `scripts/core/set-ready-fields.sh`
  - thin wrapper for `kob workitem set-ready`

- `scripts/core/create-topic.sh`
  - thin wrapper for `kob topic create`

- `scripts/core/switch-topic.sh`
  - thin wrapper for `kob topic switch`

## Doc updates

- `README.md`
  - helper block now includes the create/update wrapper set

- `docs/index.md`
  - helper block now includes the same create/update wrapper set

## Verification

- `bash scripts/core/create-workitem.sh --help`
- `bash scripts/core/set-ready-fields.sh --help`
- `bash scripts/core/create-topic.sh --help`
- `bash scripts/core/switch-topic.sh --help`
- `bash scripts/core/refresh-views.sh --help`
- `bash kob doctor`
