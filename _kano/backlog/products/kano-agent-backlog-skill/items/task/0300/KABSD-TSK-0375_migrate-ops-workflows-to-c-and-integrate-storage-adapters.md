---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-TSK-0375
iteration: backlog
links:
  blocked_by: []
  blocks: []
  relates: []
owner: None
parent: KABSD-FTR-0068
priority: P2
state: Proposed
tags: []
title: Migrate ops workflows to C++ and integrate storage adapters
type: Task
uid: 019cbf2d-0c3c-7042-b472-ac803847c419
updated: '2026-03-06'
---

# Context

Ops workflows orchestrate most business behaviors and are the highest migration risk after core semantics.

# Goal

Migrate operational workflows to C++ and integrate required adapters (filesystem, sqlite, vcs).

# Approach

Port high-usage ops first (workitem/topic/workset/view), then migrate secondary workflows and adapters with contract tests.

# Acceptance Criteria

Target ops workflows execute through C++ path with parity on critical scenarios; adapter behavior is validated in integration tests.

# Risks / Dependencies

Risk: broad surface area causes phased regressions. Dependency: phased rollout with explicit acceptance gates.

# Worklog

2026-03-06 02:05 [agent=opencode] Created item [Parent Ready gate validated]
2026-03-06 02:06 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks