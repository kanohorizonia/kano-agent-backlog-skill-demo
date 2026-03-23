# Kob Foundation Alignment

## Added repo-level foundation pieces

- `VERSION`
  - repo-level version source for the kob foundation
- `kob`, `kob.bat`
  - short alias entrypoints for `kano-backlog`
- `.agents/skills/kano/kano-agent-backlog-skill/scripts/kob`, `.agents/skills/kano/kano-agent-backlog-skill/scripts/kob.bat`
  - agent-wrapper aliases for the same native path
- `scripts/internal/show-version.sh`
  - prints the repo-level version
- `scripts/internal/self-build.sh`
  - platform-routed build entrypoint
- `scripts/internal/self-rebuild.sh`
  - platform-routed clean rebuild entrypoint

## Added build/orchestration script tree

- `src/cpp/build/script/common/build_metadata.sh`
- `src/cpp/build/script/common/unix_preset_build.sh`
- `src/cpp/build/script/linux/`
  - gcc debug/release
  - clang debug/release
  - `prerequisite_linux.sh`
- `src/cpp/build/script/macos/`
  - clang debug/release
  - clang x64 debug/release
  - clang arm64 debug/release
  - `prerequisite_macos.sh`
- `src/cpp/build/script/windows/prerequisite_windows.sh`

## Updated existing build path

- `src/cpp/build/script/common/windows_preset_build.sh`
  - now sources `build_metadata.sh`
  - now applies self-build config and collects build metadata
  - now resolves root through `KOB_CPP_ROOT` compatibility logic
- `src/cpp/build/script/common/windows_preset_helper.ps1`
  - now accepts compiler launcher information via environment

## Verified entrypaths

- `bash scripts/internal/show-version.sh`
- `bash scripts/internal/show-version.sh --short`
- `bash kob doctor`
- `bash .agents/skills/kano/kano-agent-backlog-skill/scripts/kob doctor`
- `bash scripts/internal/self-build.sh debug`
- `bash scripts/internal/self-rebuild.sh debug`
- `powershell -NoProfile -ExecutionPolicy Bypass -Command ".\kob.bat doctor"`
- `powershell -NoProfile -ExecutionPolicy Bypass -Command ".\.agents\skills\kano\kano-agent-backlog-skill\scripts\kob.bat doctor"`
- `ctest --test-dir src/cpp/build/windows-ninja-msvc --output-on-failure`

## Current status

- The repo now has a kob foundation aligned with the shape of `kano-git-master-skill`.
- Windows native build remains the fully verified path.
- Linux/macOS script trees and prerequisite flows now exist as aligned foundation scaffolding.
