---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-TSK-0371
iteration: backlog
links:
  blocked_by: []
  blocks: []
  relates: []
owner: None
parent: KABSD-FTR-0067
priority: P2
state: Completed
tags: []
title: Inventory Python modules and map to C++ package boundaries
type: Task
uid: 019cbf2b-fbb4-72a0-99ce-b26856079e1d
updated: '2026-03-09'
---

# Context

A direct rewrite without explicit module mapping risks missing behaviors and creating architecture drift.

# Goal

Produce a complete mapping from Python modules to target C++ package boundaries.

# Approach

Inventory src/python modules, classify ownership (core/ops/cli/adapters), and map each module to src/cpp systems/apps targets.

# Acceptance Criteria

Mapping table covers all in-scope Python runtime modules with C++ ownership and migration status; unresolved modules are called out with decisions needed.

# Risks / Dependencies

Risk: hidden transitive dependencies in Python implementation. Dependency: accurate module discovery and architecture review.

# Worklog

2026-03-06 02:04 [agent=opencode] Created item [Parent Ready gate validated]
2026-03-06 02:05 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks
2026-03-09 13:20 [agent=antigravity] Completed inventory of Python modules (~100 files across core/ops/cli) and mapped them to C++ package boundaries (kano_backlog_core/cli). Implementation plan approved by user. Phase 0 build scaffold initiated.