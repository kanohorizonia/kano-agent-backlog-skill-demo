# Usage Examples

This guide provides practical examples for each major CLI command group in kano-agent-backlog-skill. Each section includes common use cases with expected output and explanations.

## Table of Contents

- [Admin Commands](#admin-commands)
- [Item/Workitem Commands](#itemworkitem-commands)
- [ADR Commands](#adr-commands)
- [Topic Commands](#topic-commands)
- [Workset Commands](#workset-commands)
- [View Commands](#view-commands)
- [Common Workflows](#common-workflows)

---

## Admin Commands

Administrative commands for backlog setup, maintenance, and validation.

### Initialize a New Backlog

Create a new backlog structure for your product:

```bash
kob admin init --product my-app --agent kiro
```

**Expected Output:**
```
✓ Created backlog structure at _kano/backlog/
✓ Created product directory: _kano/backlog/products/my-app/
✓ Created item type directories (epic, feature, user_story, task, bug)
✓ Created decisions directory
✓ Created _meta directory with indexes
✓ Initialized product config at _kano/backlog/products/my-app/_config/config.toml
✓ Backlog initialized successfully
```

**What It Does:**
- Creates the directory structure for storing work items
- Sets up product-specific configuration
- Initializes metadata files for tracking IDs and indexes

### Validate Backlog Structure

Check if your backlog structure is valid:

```bash
kob validate repo-layout
```

**Expected Output:**
```
✓ Backlog root exists: _kano/backlog/
✓ Product directory exists: _kano/backlog/products/my-app/
✓ All item type directories present
✓ _meta directory structure valid
✓ Config file valid
✓ No structural issues found
```

### Create an ADR (Architecture Decision Record)

Document a significant technical decision:

```bash
kob adr create \
  --title "Use JWT for authentication" \
  --product my-app \
  --agent kiro
```

**Expected Output:**
```
✓ Created ADR: _kano/backlog/decisions/ADR-0001_use-jwt-for-authentication.md
✓ ADR ID: ADR-0001
✓ Updated ADR index
```

**What It Does:**
- Creates a new ADR file with frontmatter metadata
- Assigns a unique ADR ID
- Updates the ADR index for tracking

---

## Item/Workitem Commands

Commands for creating and managing work items (Epic, Feature, User Story, Task, Bug).

### Create an Epic

Create a high-level initiative:

```bash
kob item create --type epic \
  --title "User Authentication System" \
  --product my-app \
  --agent kiro
```

**Expected Output:**
```
✓ Created Epic: MYAPP-EPC-0001
✓ File: _kano/backlog/items/epic/0000/MYAPP-EPC-0001_user-authentication-system.md
✓ State: Proposed
```

**Item Structure:**
```markdown
---
id: MYAPP-EPC-0001
type: Epic
title: User Authentication System
state: Proposed
created: 2024-01-15T10:30:00Z
updated: 2024-01-15T10:30:00Z
product: my-app
---

# User Authentication System

## Context

<!-- Add context here -->

## Goal

<!-- Add goal here -->

## Worklog

2024-01-15 10:30 [agent=kiro] Created Epic
```

### Create a Feature Under an Epic

Create a feature linked to an epic:

```bash
kob item create --type feature \
  --title "JWT Token Management" \
  --parent MYAPP-EPC-0001 \
  --product my-app \
  --agent kiro
```

**Expected Output:**
```
✓ Created Feature: MYAPP-FTR-0001
✓ Parent: MYAPP-EPC-0001
✓ File: _kano/backlog/items/feature/0000/MYAPP-FTR-0001_jwt-token-management.md
✓ State: Proposed
```

### Create a Task

Create a concrete implementation task:

```bash
kob item create --type task \
  --title "Implement JWT token generation" \
  --parent MYAPP-FTR-0001 \
  --product my-app \
  --agent kiro
```

**Expected Output:**
```
✓ Created Task: MYAPP-TSK-0001
✓ Parent: MYAPP-FTR-0001
✓ File: _kano/backlog/items/task/0000/MYAPP-TSK-0001_implement-jwt-token-generation.md
✓ State: Proposed
```

### Set Task to Ready State

Move a task to Ready state with all required fields:

```bash
kob workitem set-ready MYAPP-TSK-0001 \
  --product my-app \
  --context "Users need secure authentication tokens for API access" \
  --goal "Generate JWT tokens with user claims and expiration" \
  --approach "Use PyJWT library with RS256 algorithm, 1-hour expiration" \
  --acceptance-criteria "Tokens contain user ID and role, expire after 1 hour, can be verified" \
  --risks "Key management needs secure storage, token refresh not in scope"
```

**Expected Output:**
```
✓ Updated Task: MYAPP-TSK-0001
✓ State: Proposed → Ready
✓ All required fields populated
✓ Worklog entry added
```

**What It Does:**
- Validates all required fields are provided
- Updates the task state to Ready
- Appends a worklog entry documenting the transition
- Enforces the "Ready gate" quality check

### Update Item State

Manually transition an item to a different state:

```bash
kob workitem update-state MYAPP-TSK-0001 \
  --state InProgress \
  --agent kiro \
  --product my-app
```

**Expected Output:**
```
✓ Updated Task: MYAPP-TSK-0001
✓ State: Ready → InProgress
✓ Worklog entry added
```

### List Items

View all items in your backlog:

```bash
kob item list --product my-app
```

**Expected Output:**
```
MYAPP-EPC-0001  Epic     Proposed    User Authentication System
MYAPP-FTR-0001  Feature  Proposed    JWT Token Management
MYAPP-TSK-0001  Task     InProgress  Implement JWT token generation
```

**Filter by Type:**
```bash
kob item list --product my-app --type task
```

**Filter by State:**
```bash
kob item list --product my-app --state InProgress
```

### Show Item Details

Display full details of a specific item:

```bash
kob workitem read MYAPP-TSK-0001 --product my-app
```

**Expected Output:**
```
ID:      MYAPP-TSK-0001
Type:    Task
Title:   Implement JWT token generation
State:   InProgress
Parent:  MYAPP-FTR-0001
Created: 2024-01-15T10:35:00Z
Updated: 2024-01-15T11:00:00Z

Context:
Users need secure authentication tokens for API access

Goal:
Generate JWT tokens with user claims and expiration

Approach:
Use PyJWT library with RS256 algorithm, 1-hour expiration

Acceptance Criteria:
Tokens contain user ID and role, expire after 1 hour, can be verified

Risks / Dependencies:
Key management needs secure storage, token refresh not in scope

Worklog:
2024-01-15 10:35 [agent=kiro] Created Task
2024-01-15 10:45 [agent=kiro] Set to Ready state
2024-01-15 11:00 [agent=kiro] State transition: Ready → InProgress
```

---

## ADR Commands

Commands for managing Architecture Decision Records.

### Create an ADR

Document a technical decision:

```bash
kob adr create \
  --title "Use PostgreSQL for user data storage" \
  --product my-app \
  --agent kiro
```

**Expected Output:**
```
✓ Created ADR: ADR-0002
✓ File: _kano/backlog/decisions/ADR-0002_use-postgresql-for-user-data-storage.md
```

**ADR Template:**
```markdown
---
id: ADR-0002
title: Use PostgreSQL for user data storage
status: Proposed
created: 2024-01-15T11:30:00Z
updated: 2024-01-15T11:30:00Z
product: my-app
---

# Use PostgreSQL for user data storage

## Status

Proposed

## Context

<!-- Describe the context and problem statement -->

## Decision

<!-- Describe the decision and rationale -->

## Consequences

### Positive

<!-- List positive consequences -->

### Negative

<!-- List negative consequences -->

## Related Items

<!-- Link to related work items -->
```

### Link ADR to Work Item

Associate an ADR with a work item:

```bash
kob worklog append MYAPP-TSK-0001 \
  --message "Linked ADR-0002 for database choice" \
  --agent kiro \
  --product my-app
```

**Expected Output:**
```
✓ Appended worklog entry to MYAPP-TSK-0001
```

---

## Topic Commands

Commands for context grouping and rapid focus area switching.

### Create a Topic

Create a new topic for related work:

```bash
kob topic create auth-refactor \
  --description "Refactor authentication system for better security" \
  --agent kiro
```

**Expected Output:**
```
✓ Created topic: auth-refactor
✓ Directory: _kano/backlog/topics/auth-refactor/
✓ Initialized topic metadata
```

### Add Items to Topic

Associate work items with a topic:

```bash
kob topic add auth-refactor --item MYAPP-TSK-0001
kob topic add auth-refactor --item MYAPP-FTR-0001
```

**Expected Output:**
```
✓ Added MYAPP-TSK-0001 to topic auth-refactor
✓ Added MYAPP-FTR-0001 to topic auth-refactor
```

### Pin Documents to Topic

Reference important documents in a topic:

```bash
kob topic pin auth-refactor \
  --doc _kano/backlog/decisions/ADR-0001_use-jwt-for-authentication.md
```

**Expected Output:**
```
✓ Pinned document to topic auth-refactor
✓ Document: ADR-0001_use-jwt-for-authentication.md
```

### Add Code Snippet Reference

Collect relevant code snippets:

```bash
kob topic add-snippet auth-refactor \
  --file src/auth/jwt.py \
  --start 10 \
  --end 25 \
  --description "JWT token generation logic" \
  --agent kiro
```

**Expected Output:**
```
✓ Added code snippet to topic auth-refactor
✓ File: src/auth/jwt.py (lines 10-25)
```

### Distill Topic Brief

Generate a summary from topic materials:

```bash
kob topic distill auth-refactor
```

**Expected Output:**
```
✓ Generated topic brief: _kano/backlog/topics/auth-refactor/brief.md
✓ Included 2 items, 1 document, 1 code snippet
```

### Switch Active Topic

Change focus to a different topic:

```bash
kob topic switch auth-refactor --agent kiro
```

**Expected Output:**
```
✓ Switched to topic: auth-refactor
✓ Context loaded: 2 items, 1 document, 1 snippet
```

### Export Topic Context

Export topic data for external use:

```bash
kob topic export-context auth-refactor --format json
```

**Expected Output:**
```json
{
  "topic_id": "auth-refactor",
  "description": "Refactor authentication system for better security",
  "items": ["MYAPP-TSK-0001", "MYAPP-FTR-0001"],
  "documents": ["ADR-0001_use-jwt-for-authentication.md"],
  "snippets": [
    {
      "file": "src/auth/jwt.py",
      "start_line": 10,
      "end_line": 25,
      "description": "JWT token generation logic"
    }
  ]
}
```

### Close Topic

Mark a topic as complete:

```bash
kob topic close auth-refactor --agent kiro
```

**Expected Output:**
```
✓ Closed topic: auth-refactor
✓ Status: Active → Closed
```

---

## Workset Commands

Commands for per-item execution cache to prevent agent drift.

### Initialize Workset

Create a workset for a task:

```bash
kob workset init --item MYAPP-TSK-0001 --agent kiro
```

**Expected Output:**
```
✓ Initialized workset for MYAPP-TSK-0001
✓ Directory: _kano/backlog/worksets/MYAPP-TSK-0001/
✓ Created plan.md from acceptance criteria
✓ Created notes.md for working notes
✓ Created deliverables/ directory
```

**Workset Structure:**
```
_kano/backlog/worksets/MYAPP-TSK-0001/
├── plan.md              # Checklist derived from acceptance criteria
├── notes.md             # Working notes with decision markers
├── deliverables/        # Staging area for work artifacts
└── _meta.json           # Workset metadata
```

### Get Next Action

Retrieve the next uncompleted item from the plan:

```bash
kob workset next --item MYAPP-TSK-0001
```

**Expected Output:**
```
Next Action:
- [ ] Implement token generation function with user claims

Remaining: 3 of 5 tasks
```

### Detect ADR Candidates

Identify decisions that should become ADRs:

```bash
kob workset detect-adr --item MYAPP-TSK-0001
```

**Expected Output:**
```
Found 1 decision marker in notes.md:

Decision: Use RS256 algorithm instead of HS256
Rationale: Better security with asymmetric keys
Location: notes.md:15

Suggestion: Create ADR for this decision
```

### Promote Deliverables

Move completed work from workset to canonical locations:

```bash
kob workset promote --item MYAPP-TSK-0001 --agent kiro
```

**Expected Output:**
```
✓ Promoted deliverables from workset MYAPP-TSK-0001
✓ Moved: deliverables/jwt.py → src/auth/jwt.py
✓ Moved: deliverables/test_jwt.py → tests/auth/test_jwt.py
✓ Updated worklog
```

### Refresh Workset Plan

Regenerate plan from updated acceptance criteria:

```bash
kob workset refresh --item MYAPP-TSK-0001
```

**Expected Output:**
```
✓ Refreshed plan for MYAPP-TSK-0001
✓ Updated plan.md with current acceptance criteria
⚠ Warning: Manual edits to plan.md will be overwritten
```

### Clean Up Expired Worksets

Remove old worksets that are no longer needed:

```bash
kob workset cleanup --ttl-hours 72 --dry-run
```

**Expected Output:**
```
Found 2 expired worksets (older than 72 hours):
- MYAPP-TSK-0005 (last modified: 4 days ago)
- MYAPP-TSK-0012 (last modified: 5 days ago)

Run without --dry-run to delete
```

**Actually Delete:**
```bash
kob workset cleanup --ttl-hours 72
```

**Expected Output:**
```
✓ Deleted 2 expired worksets
✓ Freed 1.2 MB of disk space
```

---

## View Commands

Commands for generating dashboards and reports.

### Refresh Product Views

Generate Obsidian Dataview dashboards:

```bash
kob view refresh --product my-app --agent kiro
```

**Expected Output:**
```
✓ Generated dashboard: _kano/backlog/products/my-app/views/Dashboard.md
✓ Generated by-state view: _kano/backlog/products/my-app/views/ByState.md
✓ Generated by-type view: _kano/backlog/products/my-app/views/ByType.md
✓ Generated recent activity: _kano/backlog/products/my-app/views/RecentActivity.md
```

### Inspect Refreshed View Files

Inspect the refreshed view directory after running `kob view refresh`:

```bash
ls _kano/backlog/products/my-app/views
```

**Expected Output:**
```
Dashboard.md
ByState.md
ByType.md
RecentActivity.md
```

### Inspect Effective Product Configuration

Inspect the effective configuration for a product:

```bash
kob config show --product my-app
```

**Expected Output:**
```
# Project-Level Backlog Configuration
[defaults]
auto_refresh = true
...
[products.my-app]
name = "my-app"
...
```

---

## Common Workflows

### Workflow 1: Create Epic → Feature → Task

Complete workflow from high-level initiative to concrete task:

```bash
# 1. Create an Epic
kob item create --type epic \
  --title "User Authentication System" \
  --product my-app \
  --agent kiro

# Output: Created MYAPP-EPC-0001

# 2. Create a Feature under the Epic
kob item create --type feature \
  --title "JWT Token Management" \
  --parent MYAPP-EPC-0001 \
  --product my-app \
  --agent kiro

# Output: Created MYAPP-FTR-0001

# 3. Create a Task under the Feature
kob item create --type task \
  --title "Implement JWT token generation" \
  --parent MYAPP-FTR-0001 \
  --product my-app \
  --agent kiro

# Output: Created MYAPP-TSK-0001

# 4. Set Task to Ready with all required fields
kob workitem set-ready MYAPP-TSK-0001 \
  --product my-app \
  --context "Users need secure authentication tokens" \
  --goal "Generate JWT tokens with user claims" \
  --approach "Use PyJWT library with RS256" \
  --acceptance-criteria "Tokens contain user ID, expire after 1 hour" \
  --risks "Key management needs secure storage"

# Output: Task moved to Ready state

# 5. Start work with a workset
kob workset init --item MYAPP-TSK-0001 --agent kiro

# Output: Workset initialized

# 6. Update state to InProgress
kob workitem update-state MYAPP-TSK-0001 \
  --state InProgress \
  --agent kiro \
  --product my-app

# Output: State updated to InProgress

# 7. Complete work and promote deliverables
kob workset promote --item MYAPP-TSK-0001 --agent kiro

# Output: Deliverables promoted

# 8. Update state to Done
kob workitem update-state MYAPP-TSK-0001 \
  --state Done \
  --agent kiro \
  --product my-app

# Output: State updated to Done
```

### Workflow 2: Bug Triage and Fix

Handle a bug report from discovery to resolution:

```bash
# 1. Create a Bug
kob item create --type bug \
  --title "JWT tokens expire too quickly" \
  --product my-app \
  --agent kiro

# Output: Created MYAPP-BUG-0001

# 2. Set Bug to Ready with investigation details
kob workitem set-ready MYAPP-BUG-0001 \
  --product my-app \
  --context "Users report being logged out after 5 minutes" \
  --goal "Fix token expiration to match 1-hour requirement" \
  --approach "Update token generation to use 3600 seconds instead of 300" \
  --acceptance-criteria "Tokens expire after 1 hour, existing tests pass" \
  --risks "Need to verify refresh token logic still works"

# Output: Bug moved to Ready state

# 3. Start work
kob workitem update-state MYAPP-BUG-0001 \
  --state InProgress \
  --agent kiro \
  --product my-app

# 4. Initialize workset for investigation
kob workset init --item MYAPP-BUG-0001 --agent kiro

# 5. Complete fix and update state
kob workitem update-state MYAPP-BUG-0001 \
  --state Done \
  --agent kiro \
  --product my-app
```

### Workflow 3: Context Switching with Topics

Switch between different work areas:

```bash
# 1. Create topic for authentication work
kob topic create auth-work --agent kiro

# 2. Add relevant items
kob topic add auth-work --item MYAPP-TSK-0001
kob topic add auth-work --item MYAPP-BUG-0001

# 3. Pin relevant ADRs
kob topic pin auth-work \
  --doc _kano/backlog/decisions/ADR-0001_use-jwt-for-authentication.md

# 4. Work on authentication tasks...

# 5. Switch to different topic
kob topic create api-refactor --agent kiro

kob topic switch api-refactor --agent kiro

# 6. Later, switch back to authentication work
kob topic switch auth-work --agent kiro

# Output: Context loaded with all auth-related items and documents
```

### Workflow 4: Multi-Agent Handoff

Pass work between different agents:

```bash
# Agent 1 (Kiro) creates and starts task
kob item create --type task \
  --title "Add rate limiting to API" \
  --product my-app \
  --agent kiro

kob workitem set-ready MYAPP-TSK-0010 \
  --product my-app \
  --context "API needs protection from abuse" \
  --goal "Implement rate limiting middleware" \
  --approach "Use Redis for distributed rate limiting" \
  --acceptance-criteria "Max 100 requests per minute per IP" \
  --risks "Need Redis instance in production"

kob workitem update-state MYAPP-TSK-0010 \
  --state InProgress \
  --agent kiro \
  --product my-app

# Agent 1 adds progress note
kob worklog append MYAPP-TSK-0010 \
  --message "Started implementation, Redis client configured" \
  --agent kiro \
  --product my-app

# Agent 2 (Copilot) takes over
kob worklog append MYAPP-TSK-0010 \
  --message "Continuing work from Kiro, implementing middleware" \
  --agent copilot \
  --product my-app

# Agent 2 completes work
kob workitem update-state MYAPP-TSK-0010 \
  --state Done \
  --agent copilot \
  --product my-app
```

### Workflow 5: Decision Documentation

Capture an important technical decision:

```bash
# 1. Create ADR for the decision
kob adr create \
  --title "Use Redis for rate limiting storage" \
  --product my-app \
  --agent kiro

# Output: Created ADR-0003

# 2. Edit the ADR file to add context and rationale
# (Edit _kano/backlog/decisions/ADR-0003_use-redis-for-rate-limiting-storage.md)

# 3. Link ADR to related task
kob worklog append MYAPP-TSK-0010 \
  --message "Documented decision in ADR-0003" \
  --agent kiro \
  --product my-app

# 4. Reference ADR in task notes
kob workset init --item MYAPP-TSK-0010 --agent kiro
# Add "See ADR-0003 for storage decision" to notes.md
```

---

## Tips and Best Practices

### Use Worksets for Complex Tasks

Worksets help prevent agent drift by providing:
- A clear plan derived from acceptance criteria
- A place for working notes and decision markers
- A staging area for deliverables before promotion

Always initialize a workset for tasks that will take multiple steps or involve multiple files.

### Document Decisions Early

Don't wait until the end to document decisions. Use:
- **Worklog entries** for small decisions and progress notes
- **ADRs** for significant architectural or technical decisions
- **Decision markers** in workset notes.md for potential ADRs

### Leverage Topics for Context Switching

When working on multiple features or bug fixes:
- Create a topic for each focus area
- Add relevant items, documents, and code snippets
- Use `topic switch` to quickly load context
- Close topics when work is complete

### Enforce the Ready Gate

Never start work on a Task or Bug without:
- Clear context explaining why the work is needed
- Specific goal defining what success looks like
- Concrete approach describing how to implement
- Testable acceptance criteria for verification
- Identified risks and dependencies

Use `workitem set-ready` to enforce this discipline.

### Keep Worklogs Append-Only

Never edit or delete worklog entries. The worklog is an audit trail:
- Append new entries to correct mistakes
- Include agent identity in every entry
- Add timestamps automatically
- Reference ADRs and related items

### Use Hierarchical Structure

Organize work hierarchically:
- **Epic**: Large initiative (e.g., "User Authentication System")
- **Feature**: Cohesive capability (e.g., "JWT Token Management")
- **User Story**: User need (e.g., "As a user, I want to stay logged in")
- **Task**: Implementation work (e.g., "Implement token generation")
- **Bug**: Defect to fix (e.g., "Tokens expire too quickly")

This provides clear traceability from high-level goals to concrete work.

---

## Getting Help

For more information on available commands:

```bash
kob
bash scripts/core/status.sh
bash scripts/core/create-workitem.sh --help
```

For detailed documentation:
- [Quick Start Guide](quick-start.md)
- [Configuration Guide](configuration.md)
- [Workset Documentation](workset.md)
- [Topic Documentation](topic.md)
- [Schema Reference](../references/schema.md)
- [Workflow Guide](../references/workflow.md)
