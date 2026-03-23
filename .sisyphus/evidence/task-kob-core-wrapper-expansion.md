# Kob Core Wrapper Expansion

## Added scripts/core wrappers

- `scripts/core/list-topics.sh`
  - thin wrapper for `kob topic list`

- `scripts/core/list-worksets.sh`
  - thin wrapper for `kob workset list`

- `scripts/core/check-config.sh`
  - validates config by default
  - shows config with `--show`

- `scripts/core/init-sandbox.sh`
  - thin wrapper for `kob sandbox init`

## Doc updates

- `README.md`
  - helper block now includes list-topics, list-worksets, and check-config

- `docs/index.md`
  - helper block now includes the same expanded core wrapper surface

## Verification

- `bash scripts/core/list-topics.sh`
- `bash scripts/core/list-worksets.sh`
- `bash scripts/core/check-config.sh`
- `bash scripts/core/check-config.sh --show`
- `bash scripts/core/init-sandbox.sh --help`
- `bash kob doctor`
