# Kob Docs Surface Cleanup

## Scope

Updated the next most visible repo-local documentation surfaces to prefer supported `kob` flows instead of older `kano-backlog` command examples.

## Updated files

- `docs/quick-start.md`
  - local verification now uses `bash scripts/internal/show-version.sh` and `kob`
  - backlog initialization examples now use `kob admin init`
  - item read/update examples now use the currently supported `workitem` forms where needed

- `docs/usage-examples.md`
  - command discovery/help section now uses supported `kob` and wrapper-help flows

- `scripts/prerequisite.sh`
  - local verification messaging now points to native `kob` flows
  - availability check recognizes repo-local `kob`

## Verification

- `bash kob`
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`
- `bash scripts/core/create-workitem.sh --help`

## Notes

- Historical benchmark/release records were left unchanged.
- Some deeper docs may still contain legacy examples and can be cleaned in later passes.
