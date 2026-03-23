# Kob Normalized Script Entrypoints

## Added top-level script/ wrappers

- `script/bootstrap`
  - delegates to `scripts/prerequisite.sh install`

- `script/setup`
  - delegates to `scripts/internal/self-build.sh debug`

- `script/test`
  - delegates to native `ctest`

- `script/cibuild`
  - runs `script/setup` followed by `script/test`

## Doc updates

- `README.md`
  - repository structure now documents `script/`
  - helper block now includes bootstrap/setup/test examples

- `docs/index.md`
  - helper block now includes the same normalized script entrypoints

## Verification

- `bash script/bootstrap --help`
- `bash script/setup`
- `bash script/test`
- `bash script/cibuild`

## Notes

- `script/bootstrap --help` forwards to the existing prerequisite help/usage surface.
- The normalized entrypoints stay intentionally thin and delegate to existing supported flows.
