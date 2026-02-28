# Backlog Webview (C++ Drogon): Multi-Product Tree + Kanban (Read-Only)

## TL;DR

Build a local-only (127.0.0.1) C++ Drogon web app that reads backlog markdown files under `_kano/backlog/products/*/items/` and renders:
- a multi-product switcher (N products)
- a hierarchy tree view (Epic -> Feature -> UserStory/Story -> Task/Bug, plus optional Task -> Task)
- a kanban board with simplified lanes derived from `state`

MVP is read-only. Remote access is via Tailscale only.

Estimated effort: Medium
Parallel execution: YES (3 waves + verification)
Critical path: Server scaffold -> Data extraction -> API -> UI integration -> QA

---

## Context

### Original Request
- Visualize backlog with a tree hierarchy and a kanban board, plus simple management functions later.
- Start with research, then plan.

### Decisions Captured
- Server runtime: allowed for this work (but must be reflected in `AGENTS.md` to avoid policy mismatch).
- Architecture: local HTTP server reading markdown files directly (no DB/index required for MVP correctness).
- Tech: C++ + Drogon.
- MVP: read-only.
- Network: bind localhost only; remote access via Tailscale.
- Multi-product: UI supports N products (dropdown/tabs).
- Kanban: simplified lanes mapping (Backlog/Doing/Blocked/Review/Done).
- Automated tests: none for MVP; rely on agent-executed QA scenarios (curl + browser).

### Existing Repo Evidence
- Backlog schema reference: `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md`
- Existing derived views (for cross-checking correctness):
  - `_kano/backlog/products/kano-agent-backlog-skill/views/Dashboard_PlainMarkdown_Active.md`
  - `_kano/backlog/products/kano-commit-convention-skill/views/Dashboard_PlainMarkdown_Active.md`
  - `_kano/backlog/products/kano-opencode-quickstart/views/Dashboard_PlainMarkdown_Active.md`
- C++ implementation convention skill:
  - `.agents/skills/kano/kano-cpp-dev-convention/` (must be read by the executing agent before implementation)

### Metis Gap Analysis (key points to address)
- Policy mismatch risk: `AGENTS.md` contains an explicit no-server clause (must be removed/amended by human).
- Product inconsistency: `kano-commit-convention-skill` uses `items/story/` (not `items/userstory/`).
- Must skip non-items: Epic `.index.md` MOC files; `README.md` in type dirs; `_trash/`.
- Data hazards: duplicates of same `id` across files; demo `DM-` IDs; deprecated duplicates.

---

## Work Objectives

### Core Objective
Provide a reliable read-only web visualization over the canonical markdown backlog (files remain source-of-truth).

### Concrete Deliverables
- A runnable local web app (C++ Drogon) with read-only JSON endpoints and a browser UI.
- Multi-product selector.
- Tree view and kanban view, driven from parsed frontmatter + link relationships.
- Clear guardrails and security defaults (localhost bind, path allowlist, no write endpoints).

### Must NOT Have (Guardrails)
- No write endpoints in MVP (no state changes, no item CRUD).
- No binding to `0.0.0.0` by default.
- No serving arbitrary filesystem paths (strict allowlist under `_kano/backlog/products/`).
- No reliance on derived dashboards as a data source (dashboards are for cross-check only).

---

## Verification Strategy

### Test Decision
- Infrastructure exists: no C++ test infra currently.
- Automated tests: None for MVP.
- Verification relies on agent-executed QA scenarios:
  - Start server, call endpoints via curl, validate JSON shape.
  - Open UI in a browser (Playwright skill), assert key elements and content.

Evidence policy:
- Save outputs to `.sisyphus/evidence/` (curl responses, screenshots).

---

## Execution Strategy

### Parallel Execution Waves

Wave 1 (Foundation, can start immediately)
1) Policy/ADR decisions + repo scaffolding for C++ server
2) Data model contracts (JSON shapes + kanban mapping + tree rules)
3) Product discovery rules and path allowlists
4) UI wireframe + route map
5) QA scenario definition and evidence naming

Wave 2 (Backend data + API)
6) Markdown/frontmatter parser and item loader
7) Item registry + duplicate-ID policy + non-item skipping
8) Hierarchy builder (tree) + cycle/orphan handling
9) Kanban lane builder + filters
10) Read-only HTTP JSON endpoints + static UI serving

Wave 3 (Frontend)
11) Multi-product switcher
12) Tree UI (expand/collapse + quick search)
13) Kanban UI (lanes + cards + click-to-detail panel)
14) Integration hardening (errors, empty states, performance)

Wave 4 (Verification)
15) End-to-end QA runs (curl + Playwright) + evidence collection
16) Docs / runbook + backlog item(s) + cleanup

Dependency notes:
- UI depends on API contracts.
- API depends on item loading/parsing + derived models.

---

## TODOs

- [ ] 1. Lift/Amend the No-Server Clause (Policy Gate)

  **What to do**:
  - Update `AGENTS.md` to remove or amend the "Temporary Clause: Local-first First, No Server Implementation Yet" section so this work (local-only server + UI) is explicitly permitted.
  - Add a short note clarifying scope: local-only, read-only MVP, bind localhost.

  **Must NOT do**:
  - Do not implicitly allow remote/public server binding by default.

  **Recommended Agent Profile**:
  - **Category**: `writing`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: Task 3+
  - **Blocked By**: None

  **References**:
  - `AGENTS.md` - contains the active no-server clause that conflicts with this plan (Metis flagged as critical blocker).

  **Acceptance Criteria**:
  - [ ] `AGENTS.md` no longer forbids local HTTP servers and web UIs, or contains an explicit exception for this work.

  **QA Scenarios**:
  - Scenario: Verify policy gate removed
    Tool: Bash
    Steps:
      1. Search `AGENTS.md` for the clause title text.
      2. Confirm the clause is removed or amended to permit local-only server.
    Evidence: .sisyphus/evidence/task-1-policy-gate.txt

- [ ] 2. Create Backlog Items for the Webview Feature

  **What to do**:
  - Create a Feature + Tasks (or a single Task) in `_kano/backlog/products/kano-agent-backlog-skill/items/` to track this work.
  - Ensure Ready-gate sections are present (Context/Goal/Approach/Acceptance Criteria/Risks).

  **Must NOT do**:
  - Do not write backlog item content in non-English.

  **Recommended Agent Profile**:
  - **Category**: `writing`
  - **Skills**: [`kano-agent-backlog-skill`]

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: Commit hygiene + traceability
  - **Blocked By**: None

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md` - required fields and states.

  **Acceptance Criteria**:
  - [ ] New item(s) exist under `_kano/backlog/products/kano-agent-backlog-skill/items/` and pass the Ready gate.

  **QA Scenarios**:
  - Scenario: Validate items are Ready
    Tool: Bash
    Steps:
      1. Run the repo's backlog validate command (if available), or open the item files and confirm required sections are non-empty.
    Evidence: .sisyphus/evidence/task-2-backlog-items.txt

- [ ] 3. Scaffold C++ Drogon App (Build + Run)

  **What to do**:
  - Add a new app directory (recommended: `apps/backlog-webview/`) with:
    - CMake project
    - Drogon dependency setup (vcpkg or vendored instructions)
    - A minimal server that binds to `127.0.0.1` and serves `/healthz`
    - Static file serving for a placeholder UI page
  - Add configuration for backlog root:
    - default: `_kano/backlog/products/`
    - override via CLI flag or env var (for fixtures / QA)
  - Add a small fixture backlog under `apps/backlog-webview/fixtures/` for QA (safe to mutate during tests).
  - Default runtime config:
    - bind: `127.0.0.1`
    - port: configurable (default to a fixed dev port; allow override via CLI/env)
  - Document dev commands: configure/build/run.

  **Must NOT do**:
  - Do not bind to `0.0.0.0` by default.
  - Do not add write endpoints.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: Backend endpoints + UI integration
  - **Blocked By**: Task 1

  **References**:
  - `.gitignore` - keep derived/build outputs out of git.
  - `.agents/skills/kano/kano-cpp-dev-convention/` - required C++ coding/build conventions for this repo.

  **Acceptance Criteria**:
  - [ ] Build produces a runnable binary.
  - [ ] `GET http://127.0.0.1:<port>/healthz` returns 200.
  - [ ] Server supports an override backlog root for fixture-based QA.

  **QA Scenarios**:
  - Scenario: Start server and hit health
    Tool: Bash
    Steps:
      1. Build and run the server.
      2. `curl -sS -i http://127.0.0.1:<port>/healthz` shows `200`.
    Evidence: .sisyphus/evidence/task-3-healthz.txt

- [ ] 4. Define Read-Only API Contracts (JSON Shapes + Routes)

  **What to do**:
  - Specify and implement a stable API surface (initial proposal):
    - `GET /api/products`
    - `GET /api/items?product=<name>` (flat list)
    - `GET /api/tree?product=<name>` (hierarchy)
    - `GET /api/kanban?product=<name>` (lanes + cards)
    - `GET /api/items/<id>?product=<name>` (detail)
  - Document response shapes and error codes.

  **Must NOT do**:
  - No mutation routes.

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: UI implementation
  - **Blocked By**: Task 3

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md` - frontmatter fields to expose.
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/conventions.md` - item paths and naming.

  **Acceptance Criteria**:
  - [ ] API routes are documented and return consistent JSON envelopes.

  **QA Scenarios**:
  - Scenario: Smoke-check API endpoints exist
    Tool: Bash
    Steps:
      1. Start server.
      2. Curl each endpoint and confirm HTTP 200/4xx behavior is documented.
    Evidence: .sisyphus/evidence/task-4-api-contracts.txt

- [ ] 5. Implement Product Discovery + Path Allowlists

  **What to do**:
  - Define "product" as a directory under `<backlog_root>/<product>/`.
  - Implement discovery by listing directories and detecting `items/`.
  - Implement strict allowlist: requests may only read files under the configured backlog root (default `_kano/backlog/products/`).
  - Exclude `_trash/` and any non-`items/` content from scans.

  **Must NOT do**:
  - No arbitrary path parameters that allow traversal outside `_kano/backlog/products/`.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: all item-scanning tasks
  - **Blocked By**: Task 3

  **References**:
  - `_kano/backlog/products/` - product roots.
  - `_kano/backlog/products/kano-agent-backlog-skill/items/` - canonical layout.

  **Acceptance Criteria**:
  - [ ] `GET /api/products` returns the expected products (at least the 3 present today).
  - [ ] Requests with `product=../..` are rejected with 400/404 (no filesystem access).

  **QA Scenarios**:
  - Scenario: Product listing + path traversal rejection
    Tool: Bash
    Steps:
      1. `curl -sS http://127.0.0.1:<port>/api/products` returns an array with 3 product names.
      2. `curl -sS -i "http://127.0.0.1:<port>/api/items?product=../.."` returns 400/404.
    Evidence: .sisyphus/evidence/task-5-products-allowlist.txt

- [ ] 6. Implement Markdown Frontmatter Parsing (Minimal, Deterministic)

  **What to do**:
  - Implement a minimal parser for YAML frontmatter blocks (`---` ... `---`) and extract required keys.
  - Parse at least: `id`, `type`, `title`, `state`, `parent`, `links.blocks`, `links.blocked_by`, `updated`, `created`.
  - Fail gracefully on malformed YAML: mark item as "invalid" in API output with error metadata, but do not crash the whole product.

  **Must NOT do**:
  - Do not attempt full Markdown rendering for MVP.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: tree/kanban derivations
  - **Blocked By**: Task 5

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md` - minimum frontmatter fields.
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/canonical_schema.json` - canonical key names.

  **Acceptance Criteria**:
  - [ ] Parser can load several real items without error.
  - [ ] Malformed frontmatter in a file does not crash the server.

  **QA Scenarios**:
  - Scenario: Parse real items
    Tool: Bash
    Steps:
      1. Start server.
      2. Call `/api/items?product=kano-agent-backlog-skill` and confirm it returns a non-empty list.
    Evidence: .sisyphus/evidence/task-6-parse-real.txt
  - Scenario: Malformed frontmatter handling
    Tool: Bash
    Steps:
      1. Point server at `apps/backlog-webview/fixtures/`.
      2. Add or edit a fixture file with malformed frontmatter.
      2. Confirm API returns an "invalid" item entry and server stays up.
    Evidence: .sisyphus/evidence/task-6-parse-malformed.txt

- [ ] 7. Implement Item Scanner with Non-Item Skips and Type-Dir Variations

  **What to do**:
  - Scan item markdown files under:
    - `items/epic/**.md`
    - `items/feature/**.md`
    - `items/userstory/**.md` and `items/story/**.md` (product-specific variation)
    - `items/task/**.md`
    - `items/bug/**.md`
  - Skip:
    - epic `.index.md` files (MOC)
    - `README.md` within type dirs
    - anything under `_trash/`

  **Must NOT do**:
  - Do not treat `.index.md` as a work item.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: tree/kanban derivations
  - **Blocked By**: Task 6

  **References**:
  - `_kano/backlog/products/kano-commit-convention-skill/items/` - uses `story/`.
  - `_kano/backlog/products/kano-agent-backlog-skill/items/epic/0000/` - contains `.index.md` siblings.

  **Acceptance Criteria**:
  - [ ] `/api/items?product=<name>` does not include `.index.md` or `README.md` entries.

  **QA Scenarios**:
  - Scenario: Verify scanner skips non-items
    Tool: Bash
    Steps:
      1. `curl -sS "http://127.0.0.1:<port>/api/items?product=kano-agent-backlog-skill"`.
      2. Confirm no returned `path` ends with `.index.md` and no item `id` is null.
    Evidence: .sisyphus/evidence/task-7-skip-nonitems.txt

- [ ] 8. Define Duplicate-ID Policy and Surface It in API

  **What to do**:
  - When multiple files share the same `id`, pick a deterministic "primary" (recommended: newest `updated` date, or newest file mtime if missing).
  - Emit a `duplicates` array in the item detail output so users can inspect conflicts.
  - Never silently merge content.

  **Must NOT do**:
  - Do not crash or drop the whole product due to duplicates.

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: tree/kanban correctness
  - **Blocked By**: Task 7

  **References**:
  - `Metis findings` - duplicates exist in the repo and must be handled deterministically.

  **Acceptance Criteria**:
  - [ ] When duplicates exist, `/api/items/<id>` includes a `duplicates` list with file paths.

  **QA Scenarios**:
  - Scenario: Duplicate ID handling
    Tool: Bash
    Steps:
      1. Point server at `apps/backlog-webview/fixtures/`.
      2. Ensure fixtures contain two files with the same `id` and different content.
      3. Call `/api/items/<id>?product=<fixture-product>`.
      4. Confirm response includes `duplicates.length >= 2`.
    Evidence: .sisyphus/evidence/task-8-duplicates.txt

- [ ] 9. Build Hierarchy Graph + Tree Projection

  **What to do**:
  - Build an in-memory graph keyed by `id`:
    - Parent edges from `parent`
    - Dependency edges from `links.blocks` / `links.blocked_by` (for future; optional to expose now)
  - Project a tree for display:
    - Roots are items with no `parent`, or with missing parent (treated as "orphan root")
    - Detect cycles (Task->Task loops) and break deterministically (emit cycle warning metadata)
  - Expose via `GET /api/tree?product=<name>`.

  **Must NOT do**:
  - Do not assume parent always exists.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: Tree UI
  - **Blocked By**: Task 8

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md` - parent rules.

  **Acceptance Criteria**:
  - [ ] `/api/tree?product=kano-agent-backlog-skill` returns a stable JSON tree.
  - [ ] Orphans and cycles are surfaced as warnings, not crashes.

  **QA Scenarios**:
  - Scenario: Tree endpoint returns roots and children
    Tool: Bash
    Steps:
      1. `curl -sS "http://127.0.0.1:<port>/api/tree?product=kano-agent-backlog-skill"`.
      2. Confirm JSON includes `roots` array with nodes having `id`, `title`, `children`.
    Evidence: .sisyphus/evidence/task-9-tree.json

- [ ] 10. Implement Kanban Lane Mapping + Queries

  **What to do**:
  - Implement simplified lanes mapping from `state`:
    - Backlog: Proposed/Planned/Ready
    - Doing: InProgress
    - Blocked: Blocked
    - Review: Review
    - Done: Done (optionally include Dropped in separate lane or hidden)
  - Expose via `GET /api/kanban?product=<name>` returning lanes with cards.
  - Support basic filters: `?owner=`, `?area=`, `?q=` (optional for MVP; include at least `q` for title).

  **Must NOT do**:
  - Do not treat derived dashboards as source; compute from items.

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: Kanban UI
  - **Blocked By**: Task 8

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md` - state enum.
  - `_kano/backlog/products/kano-agent-backlog-skill/views/Dashboard_PlainMarkdown_Active.md` - cross-check which items are active.

  **Acceptance Criteria**:
  - [ ] `/api/kanban?product=kano-agent-backlog-skill` returns exactly the defined lanes.

  **QA Scenarios**:
  - Scenario: Kanban endpoint returns lanes
    Tool: Bash
    Steps:
      1. `curl -sS "http://127.0.0.1:<port>/api/kanban?product=kano-agent-backlog-skill"`.
      2. Confirm lane keys include Backlog/Doing/Blocked/Review/Done.
    Evidence: .sisyphus/evidence/task-10-kanban.json

- [ ] 11. Implement Read-Only API Endpoints (Items, Tree, Kanban, Detail)

  **What to do**:
  - Implement the endpoints from Task 4 backed by the scanner + models:
    - Include consistent envelope `{ ok, data, warnings, errors }`.
    - Implement 404 for unknown product and unknown item id.
  - Serve static UI assets from the same server process.

  **Must NOT do**:
  - No mutation endpoints.
  - No CORS wildcard.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: all UI tasks
  - **Blocked By**: Tasks 5-10

  **References**:
  - `.gitignore` - avoid committing build outputs.

  **Acceptance Criteria**:
  - [ ] All endpoints return 200 on valid inputs.
  - [ ] Invalid product/id returns 404 with JSON error.

  **QA Scenarios**:
  - Scenario: Endpoint matrix smoke
    Tool: Bash
    Steps:
      1. Curl `/api/products`.
      2. Pick a product, curl `/api/items`, `/api/tree`, `/api/kanban`.
      3. Pick an item id, curl `/api/items/<id>`.
      4. Curl invalid product and confirm 404.
    Evidence: .sisyphus/evidence/task-11-endpoints.txt

- [ ] 12. Implement Minimal In-Memory Caching + Manual Refresh

  **What to do**:
  - Cache per-product item lists in memory with an mtime-based invalidation key.
  - Provide a manual refresh endpoint or UI button that forces rescan (read-only still).
  - Keep caching simple; full file watching is optional and can be deferred.

  **Must NOT do**:
  - Do not introduce SQLite indexing in MVP.

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: usability + performance
  - **Blocked By**: Task 11

  **References**:
  - Metis findings: item counts are small enough for in-memory scanning; caching is optional.

  **Acceptance Criteria**:
  - [ ] Refresh action updates API results after a file change.

  **QA Scenarios**:
  - Scenario: Manual refresh reflects file changes
    Tool: Bash
    Steps:
      1. Start server pointed at `apps/backlog-webview/fixtures/`.
      2. Fetch `/api/items` and pick one fixture item.
      3. Edit the fixture file title.
      4. Trigger refresh; fetch item detail and confirm updated title appears.
    Evidence: .sisyphus/evidence/task-12-refresh.txt

- [ ] 13. Build UI Shell + Multi-Product Switcher

  **What to do**:
  - Implement a simple UI shell served by the Drogon app:
    - product switcher (dropdown or tabs)
    - navigation between Tree and Kanban views
    - error banner + loading states
  - Keep UI build simple for MVP: plain HTML + CSS + minimal vanilla JS (no Node/React build pipeline).
  - Fetch products from `/api/products`.

  **Must NOT do**:
  - Do not bake product list into the frontend.

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: Tree UI, Kanban UI
  - **Blocked By**: Task 11

  **References**:
  - `_kano/backlog/products/` - product list should reflect this directory.

  **Acceptance Criteria**:
  - [ ] UI lists all discovered products and switching updates API calls.

  **QA Scenarios**:
  - Scenario: Product switching works
    Tool: Playwright
    Steps:
      1. Open `http://127.0.0.1:<port>/`.
      2. Locate product selector and switch between 2 products.
      3. Assert view updates (e.g., item counts or product label changes).
    Evidence: .sisyphus/evidence/task-13-product-switch.png

- [ ] 14. Implement Tree View UI (Expand/Collapse + Quick Search)

  **What to do**:
  - Render `/api/tree?product=...` as an expandable tree.
  - Provide quick search/filter by title substring.
  - Display orphan/cycle warnings unobtrusively.

  **Must NOT do**:
  - Do not crash the UI on missing fields; show placeholders.

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: Final E2E QA
  - **Blocked By**: Tasks 9, 13

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/_meta/schema.md` - expected hierarchy and types.

  **Acceptance Criteria**:
  - [ ] Tree renders within 2s for current backlog size.
  - [ ] Expand/collapse works for at least 2 levels.

  **QA Scenarios**:
  - Scenario: Tree expands and filters
    Tool: Playwright
    Steps:
      1. Open Tree view.
      2. Expand an Epic node; assert children appear.
      3. Use search to filter by a known substring (e.g., "Roadmap"); assert matching nodes remain.
    Evidence: .sisyphus/evidence/task-14-tree.png

- [ ] 15. Implement Kanban View UI (Lanes + Cards + Detail)

  **What to do**:
  - Render `/api/kanban?product=...` lanes horizontally.
  - Render cards with: ID, title, type, state, parent ID (if any).
  - Card click opens a detail panel powered by `/api/items/<id>`.

  **Must NOT do**:
  - No drag-and-drop state changes in MVP.

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: none

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: Final E2E QA
  - **Blocked By**: Tasks 10, 13

  **References**:
  - `_kano/backlog/products/kano-agent-backlog-skill/views/Dashboard_PlainMarkdown_Active.md` - cross-check active items.

  **Acceptance Criteria**:
  - [ ] Kanban shows lanes Backlog/Doing/Blocked/Review/Done.
  - [ ] Clicking a card shows item details without navigation away.

  **QA Scenarios**:
  - Scenario: Kanban lanes and detail panel
    Tool: Playwright
    Steps:
      1. Open Kanban view.
      2. Assert 5 lanes exist with correct titles.
      3. Click a card in Doing or Blocked; assert detail panel shows matching ID.
    Evidence: .sisyphus/evidence/task-15-kanban.png

- [ ] 16. End-to-End QA + Runbook Documentation

  **What to do**:
  - Execute QA scenarios for Tasks 3, 5, 9-15 and store evidence.
  - Write a short runbook: how to build/run, how to access via Tailscale, and security notes.
  - Document known limitations: duplicates policy, story/userstory differences, no writes.

  **Must NOT do**:
  - Do not claim LAN/public exposure support.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
  - **Skills**: [`playwright`]

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 4
  - **Blocks**: Final Verification Wave
  - **Blocked By**: Tasks 12-15

  **References**:
  - `.sisyphus/plans/backlog-webview-drogon.md` - QA scenario list.

  **Acceptance Criteria**:
  - [ ] Evidence files exist for each scenario under `.sisyphus/evidence/`.
  - [ ] Runbook exists (path chosen by implementer) and includes build/run commands.

  **QA Scenarios**:
  - Scenario: Full E2E pass
    Tool: Playwright + Bash
    Steps:
      1. Start server.
      2. Curl `/api/products`, `/api/tree`, `/api/kanban`.
      3. Use browser to switch products, expand tree, and open kanban card detail.
    Evidence: .sisyphus/evidence/task-16-e2e.zip

---

## Final Verification Wave

- F1. Plan Compliance Audit (oracle)
- F2. Code Quality Review (unspecified-high)
- F3. End-to-End QA Execution (unspecified-high, Playwright if UI)
- F4. Scope Fidelity Check (deep)

---

## Commit Strategy

- Prefer small, reviewable commits by wave. Include relevant Kano IDs if/when items are created.

---

## Success Criteria

- Server runs locally and binds to 127.0.0.1 by default.
- Multi-product switcher lists products found under `_kano/backlog/products/`.
- Tree view renders hierarchy without crashing on malformed or missing parents.
- Kanban shows expected items grouped into simplified lanes.
- QA evidence files exist under `.sisyphus/evidence/`.
