---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-TSK-0374
iteration: backlog
links:
  blocked_by: []
  blocks: []
  relates: []
owner: None
parent: KABSD-FTR-0068
priority: P2
state: In Progress
tags: []
title: Implement C++ core domain modules and file-format invariants
type: Task
uid: 019cbf2d-0c2d-708e-8b83-f8120d52c98f
updated: '2026-03-09'
---

# Context

Core domain behavior defines canonical data integrity and must be stable before higher-layer migrations.

# Goal

Implement C++ core domain modules that preserve canonical item semantics and file-format invariants.

# Approach

Port core models/errors/validation/frontmatter contracts first, then enforce deterministic serialization and parsing behavior.

# Acceptance Criteria

Core C++ modules parse and write canonical items correctly; invariants are covered by automated tests; parity checks pass for representative core scenarios.

# Risks / Dependencies

Risk: subtle markdown/frontmatter normalization differences. Dependency: agreed serializer and fixture corpus.

# Worklog

2026-03-06 02:05 [agent=opencode] Created item [Parent Ready gate validated]
2026-03-06 02:06 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks
2026-03-09 13:25 [agent=antigravity] Initialized kano_backlog_core static library and version module. Establishing C++ project architecture following kano-git patterns. Phase 0 build scaffold in progress.