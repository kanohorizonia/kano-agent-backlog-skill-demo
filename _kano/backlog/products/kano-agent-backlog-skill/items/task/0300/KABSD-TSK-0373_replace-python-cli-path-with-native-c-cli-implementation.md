---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-TSK-0373
iteration: backlog
links:
  blocked_by: []
  blocks: []
  relates: []
owner: None
parent: KABSD-FTR-0068
priority: P2
state: InProgress
tags: []
title: 'Replace Python CLI path with native C++ CLI implementation'
type: Task
uid: 019cbf2d-0c1d-74a5-86bf-665e84cb611a
updated: '2026-03-11'
---

# Context

CLI cutover is the user-facing switch point and must preserve predictable command ergonomics.

# Goal

Replace Python CLI execution path with native C++ CLI command implementation.

# Approach

Implement command dispatch in C++, mirror required options/output contracts, and wire into build/distribution entrypoints.

# Acceptance Criteria

Primary command groups run through C++ binary; documented parity scenarios pass; old Python CLI runtime path is not required for execution.

# Risks / Dependencies

Risk: option parsing and output formatting mismatches. Dependency: compatibility matrix and golden scenario fixtures.

# Worklog

2026-03-06 02:05 [agent=opencode] Created item [Parent Ready gate validated]
2026-03-06 02:06 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks
2026-03-09 13:25 [agent=antigravity] Initialized C++ CLI entry point (main.cpp) with CLI11 command stubs mirroring Python CLI command groups. Phase 0 build scaffold in progress.
2026-03-09 22:15 [agent=antigravity] Phase 0 complete. Phase 1 in progress: Ported `models` and `config` modules to C++. Currently BLOCKED by `yaml-cpp` configuration failure (see KABSD-BUG-0016).
2026-03-11 00:00 [agent=opencode] Workset initialized: D:\_work\_Kano\kano-agent-backlog-skill-demo\_kano\backlog\.cache\worksets\items\KABSD-TSK-0373
2026-03-11 00:00 [agent=opencode] Workset refreshed: D:\_work\_Kano\kano-agent-backlog-skill-demo\_kano\backlog\.cache\worksets\items\KABSD-TSK-0373
2026-03-11 00:00 [agent=opencode] Promoted 1 deliverable(s) to D:\_work\_Kano\kano-agent-backlog-skill-demo\_kano\backlog\products\kano-agent-backlog-skill\artifacts\KABSD-TSK-0373: promote-smoke.txt
