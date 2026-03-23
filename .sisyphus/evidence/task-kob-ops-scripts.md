# Kob Operational Scripts Alignment

## Added scripts

- `scripts/internal/bump-version.sh`
  - bumps `VERSION`
  - supports `major|minor|patch`
  - supports `--dry-run`

- `scripts/internal/create-tag.sh`
  - creates an annotated git tag
  - supports `--from-version-file`
  - supports `--dry-run`

- `scripts/tags/list-tags.sh`
  - lists repository tags
  - supports `--latest`
  - supports `--detailed`

## Doc alignment

- `README.md`
  - now documents version/tag helpers in the kob foundation section
- `docs/index.md`
  - now includes the new kob operational helpers in Quick Start

## Verification

- `bash scripts/internal/show-version.sh`
- `bash scripts/internal/bump-version.sh patch --dry-run`
- `bash scripts/internal/create-tag.sh --from-version-file --dry-run`
- `bash scripts/tags/list-tags.sh --latest`
- `bash kob topic list`

## Notes

- Tag creation was verified in dry-run mode only.
- No git tags were created during verification.
