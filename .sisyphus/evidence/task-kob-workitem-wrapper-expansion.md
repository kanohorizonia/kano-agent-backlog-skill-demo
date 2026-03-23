# Kob Workitem Wrapper Expansion

## Added scripts/core wrappers

- `scripts/core/list-workitems.sh`
  - thin wrapper for `kob workitem list`

- `scripts/core/read-workitem.sh`
  - thin wrapper for `kob workitem read`

- `scripts/core/update-workitem-state.sh`
  - thin wrapper for `kob workitem update-state`

- `scripts/core/append-worklog.sh`
  - thin wrapper for `kob worklog append`

## Doc updates

- `README.md`
  - helper block now includes workitem list/read examples

- `docs/index.md`
  - helper block now includes workitem list/read examples

## Verification

- `bash scripts/core/list-workitems.sh --product guide-test --backlog-root _kano/backlog_sandbox/_tmp_tests/guide_test_backlog`
- `bash scripts/core/read-workitem.sh GT-TSK-0013 --product guide-test --backlog-root _kano/backlog_sandbox/_tmp_tests/guide_test_backlog`
- `bash scripts/core/update-workitem-state.sh --help`
- `bash scripts/core/append-worklog.sh --help`
- `bash kob doctor`
