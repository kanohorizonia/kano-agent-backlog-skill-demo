---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-FTR-0068
iteration: backlog
links:
  blocked_by: []
  blocks: []
  relates: []
owner: None
parent: KABSD-EPIC-0018
priority: P2
state: Proposed
tags: []
title: Implement phased C++ runtime replacement and remove Python execution path
type: Feature
uid: 019cbf2b-fb8d-706d-a770-e8dc1632ffd6
updated: '2026-03-06'
---

# Context

After architecture and contracts are defined, the runtime must be migrated to C++ in executable phases to reduce risk and maintain delivery progress.

# Goal

Implement all required backlog runtime capabilities in C++ and retire Python from the production execution path.

# Approach

Migrate in layers (core, ops, cli), validate each stage with parity tests, then remove Python runtime and packaging artifacts in one controlled cutover.

# Acceptance Criteria

C++ runtime covers required command surface; parity validation passes for canonical workflows; Python runtime path is removed from active execution and build/install flow.

# Risks / Dependencies

Risk: parity gaps in edge-case parsing and command UX. Dependency: stable C++ build tooling, test harness, and migration sequencing discipline.

# Worklog

2026-03-06 02:04 [agent=opencode] Created item [Parent Ready gate validated]
2026-03-06 02:05 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks