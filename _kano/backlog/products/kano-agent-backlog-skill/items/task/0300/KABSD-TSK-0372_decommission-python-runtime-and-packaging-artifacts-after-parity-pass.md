---
area: general
created: '2026-03-06'
decisions: []
external:
  azure_id: null
  jira_key: null
id: KABSD-TSK-0372
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
title: Decommission Python runtime and packaging artifacts after parity pass
type: Task
uid: 019cbf2d-0c10-7209-9290-e3e2b7a0e9f8
updated: '2026-03-06'
---

# Context

Python runtime components must be removed only after parity is proven to avoid service regressions.

# Goal

Retire Python runtime and packaging artifacts from active execution once C++ parity gates pass.

# Approach

Define removal checklist, update build/install paths, remove Python runtime entrypoints, and keep only required non-runtime assets.

# Acceptance Criteria

Python runtime path is no longer used for execution; build/docs reflect C++ runtime; obsolete Python runtime artifacts are removed.

# Risks / Dependencies

Risk: accidental removal of still-required tooling scripts. Dependency: completed parity and migration sign-off.

# Worklog

2026-03-06 02:05 [agent=opencode] Created item [Parent Ready gate validated]
2026-03-06 02:06 [agent=opencode] Updated Ready fields: Context, Goal, Approach, Acceptance Criteria, Risks