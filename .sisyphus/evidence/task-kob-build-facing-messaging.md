# Kob Build-Facing Messaging Alignment

## Scope

Aligned build-facing messages so current local usage points to `kob` first, while preserving `kano-backlog.exe` as the underlying compatibility binary.

## Updated files

- `build.bat`
  - now uses `KOB_CPP_ROOT`
  - completion message now points to `.\kob` as the primary local surface
  - native binary is described as a compatibility detail

- `src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh`
  - now exports `KOB_CPP_ROOT`
  - now prints `./kob` as the primary local surface after build

- `src/cpp/build/script/windows/build_windows_ninja_msvc_release.sh`
  - now exports `KOB_CPP_ROOT`
  - now prints `./kob` as the primary local surface after build

## Verification

- `bash src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh`
- `build.bat`

## Result

- Build-facing messaging now reinforces `kob` as the command users should run locally.
- The actual compiled executable remains `kano-backlog.exe` for compatibility.
