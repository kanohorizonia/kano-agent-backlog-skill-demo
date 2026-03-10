---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-EPIC-0018
iteration: backlog
links:
  blocked_by: []
  blocks: []
  relates: []
owner: None
parent: null
priority: P2
state: Proposed
tags: []
title: 'C++ migration: remove Python runtime from kano-agent-backlog-skill'
type: Epic
uid: 019cbf2a-686a-7735-b5d2-48881cf1d067
updated: '2026-03-06'
---

# Context

The current implementation under .agents/skills/kano/kano-agent-backlog-skill/src/python is Python-centric. We need a production migration plan to re-implement the runtime in C++ and remove Python from the execution path.

# Goal

Define and execute a complete migration to a C++ runtime architecture while preserving deterministic backlog behavior and CLI capabilities.

# Approach

Create an epic-driven migration plan: architecture contract first, core/ops/cli phased replacement, parity verification, and final Python runtime removal.

# Acceptance Criteria

A formal migration plan is documented; child feature/task items exist for architecture, phased implementation, verification, and decommissioning; each child item has explicit acceptance criteria.

# Risks / Dependencies

Risk: behavior drift in markdown/frontmatter handling, state transitions, and view generation. Dependency: C++ build/runtime toolchain and a validation harness for parity checks.

# Worklog

2026-03-06 02:02 [agent=opencode] Created item
2026-03-06 02:03 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks
2026-03-06 02:08 [agent=opencode] Artifact attached: [cpp-migration-python-elimination-plan.md](..\..\..\..\..\_shared\artifacts\KABSD-EPIC-0018\cpp-migration-python-elimination-plan.md) — Added formal C++ migration and Python runtime removal plan.
2026-03-06 07:11 [agent=opencode] Artifact attached: [cpp-runtime-architecture.md](..\..\..\..\..\_shared\artifacts\KABSD-EPIC-0018\cpp-runtime-architecture.md) — Linked architecture diagram and module split for migration planning.
