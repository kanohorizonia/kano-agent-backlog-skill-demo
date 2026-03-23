# Kob Native Branding Alignment

## Scope

Updated the native C++ CLI branding so the default usage surface now presents `kob` instead of `kano-backlog` for local execution.

## Changes

- `src/cpp/apps/kano_backlog_cli/main.cpp`
  - usage/help strings now present `kob` as the command name

- `README.md`
  - high-visibility local examples continue to use `kob`
  - workset/topic/config/troubleshooting examples in the main README were promoted to `kob`

## Verification

- `bash src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh`
- `ctest --test-dir src/cpp/build/windows-ninja-msvc --output-on-failure`
- `bash kob`
- `bash kob doctor`
- `bash kob topic list`

## Result

- The native binary now reports `Usage: kob <command> [options]`.
- The primary local repo command surface reads consistently as `kob` across wrappers, docs, and native usage output.
