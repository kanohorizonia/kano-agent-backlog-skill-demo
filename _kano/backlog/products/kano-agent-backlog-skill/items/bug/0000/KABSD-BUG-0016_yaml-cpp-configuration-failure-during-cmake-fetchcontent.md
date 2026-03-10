---
area: build
created: '2026-03-09'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-BUG-0016
iteration: backlog
links:
  blocked_by: []
  blocks:
  - KABSD-TSK-0373
  relates: []
owner: None
parent: KABSD-FTR-0068
priority: P1
state: Done
tags:
- c-migration
- blocker
title: yaml-cpp configuration failure during CMake FetchContent in Phase 1 migration
type: Bug
uid: 019cbf2e-0c1d-74a5-86bf-665e84cb611b
updated: '2026-03-09'
---

# Context

Phase 1 of the C++ migration involves porting the `frontmatter` parsing logic, which requires `yaml-cpp`. Adding `yaml-cpp` v0.8.0 via `FetchContent` in the Ninja + Clang environment on Windows.

# Goal

Successfully configure and build `yaml-cpp` as a dependency for `kano_backlog_core`.

# Approach

1. Investigate `CMakeConfigureLog.yaml` for root cause of the configuration failure.
2. Adjust `yaml-cpp` version or configuration flags (e.g., `YAML_CPP_BUILD_TESTS=OFF`).
3. Verify successful linking with `kano_backlog_core`.

# Acceptance Criteria

- `cmake` configuration completes without errors.
- `yaml-cpp` targets are available for linking.
- `kano_backlog_core` compiles with `yaml-cpp` headers included.

# Risks / Dependencies

Blocked by: CMake environment or `yaml-cpp` build script incompatibility with the current Ninja Multi-Config + Clang preset.

# Worklog

2026-03-09 22:15 [agent=antigravity] Created bug report. Encountered during Phase 1 migration. `models` and `config` modules are already ported and compiled successfully.
2026-03-09 22:35 [agent=antigravity] Root cause identified: `GIT_TAG` was set to `yaml-cpp-0.8.0` but the actual git tag in the repository is `0.8.0`. Corrected `CMakeLists.txt` and retrying build.
2026-03-09 22:45 [agent=antigravity] Encountered second error: CMake 4.2.3 deprecates compatibility with CMake < 3.5. `yaml-cpp` uses 3.4. Applied `set(CMAKE_POLICY_VERSION_MINIMUM 3.5)` as a workaround. Retrying build.


