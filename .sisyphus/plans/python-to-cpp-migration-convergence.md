# Python-to-C++ Migration Convergence

## TL;DR

> **Quick Summary**: Converge the migration by proving that normal `kano-backlog` execution is fully native C++, then harden build/test flows and clean up or quarantine repo-root Python artifacts that are no longer justified.
>
> **Deliverables**:
> - Verified zero-active-Python runtime path for normal `kano-backlog` usage
> - Native build/test/smoke harness for the C++ CLI
> - Explicit classification and cleanup/quarantine of demo-repo Python artifacts
> - Updated documentation of the new runtime boundary and residual legacy policy
>
> **Estimated Effort**: Medium
> **Parallel Execution**: YES - 3 waves + final verification
> **Critical Path**: 1 → 6 → 11 → F1-F4

---

## Context

### Original Request
Continue the Python-to-C++ migration until Python disappears from the active `kano-backlog` execution path, using the new `src/cpp/build/script/` layout modeled after the reference build-script structure.

### Interview Summary
**Key Discussions**:
- Completion bar was clarified: **"Python disappears" means no active Python execution path for normal `kano-backlog` usage**.
- Python files may remain temporarily as **inert legacy/reference code**.
- Remaining migration work should use a **tests-after** strategy, not TDD-first.
- Planning should focus on convergence, not open-ended feature expansion.

**Research Findings**:
- `src/cpp/apps/kano_backlog_cli/main.cpp:1-120` shows the native CLI is the current primary entry surface.
- `src/cpp/CMakeLists.txt:1-32` builds the native executable but currently has no test targets.
- `build.bat:1-8` and `src/cpp/build/script/common/windows_preset_build.sh:1-42` show two overlapping Windows build paths.
- `src/cpp/build/script/common/windows_preset_helper.ps1:15-80` already contains VS2022-first detection logic.
- `tests/test_chunking_mvp.py:1-64`, `tests/test_pipeline_config.py:1-45`, `tests/embedding/test_noop.py:1-54`, and `tests/vector/test_vector_adapter.py:1-37` are Python tests aimed at Python skill/submodule code.
- `requirements.txt:1-15`, `setup.py:1-40`, `conftest.py:1-26`, and `scripts/verify_config.py:1-13` confirm repo-root Python tooling still exists outside the active CLI path.
- `.agents/skills/kano/kano-agent-backlog-skill/src/python/` remains a large Python reference implementation and is treated as acceptable temporary legacy/reference scope.

### Metis Review
**Identified Gaps** (addressed):
- Potential scope creep into large-scale `main.cpp` decomposition was identified and explicitly excluded from this convergence plan.
- Residual Python artifact ambiguity was resolved by adding a classification-and-policy task before cleanup.
- Missing acceptance criteria around "proof of no Python runtime path" were resolved by requiring command-matrix evidence and explicit negative checks.

---

## Work Objectives

### Core Objective
Prove and harden a fully native `kano-backlog` execution path for normal use, then reduce repo-root Python residue to clearly documented non-runtime legacy/tooling only.

### Concrete Deliverables
- Native smoke/build verification path centered on `src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh`
- C++ test harness wired into `src/cpp/CMakeLists.txt`
- Repo-root Python artifact classification matrix with deterministic cleanup rules
- Documentation updates describing what is removed, what remains, and why
- Evidence bundle proving that normal `kano-backlog` usage does not invoke Python

### Definition of Done
- [ ] Building through the new Windows preset script succeeds and produces `kano-backlog.exe`
- [ ] Representative normal-use command matrix executes through the native binary with no Python dependency in the active path
- [ ] C++ smoke tests run through CTest or equivalent native test command
- [ ] Repo-root Python files are either removed, replaced, or explicitly documented as non-runtime residuals
- [ ] Documentation clearly states the active runtime boundary and residual legacy boundary

### Must Have
- Native build path uses the new `src/cpp/build/script/` stack
- Tests-after strategy: add targeted native smoke tests after hardening the affected paths
- Explicit proof artifacts for runtime-path verification
- No hidden Python fallback in normal `kano-backlog` execution

### Must NOT Have (Guardrails)
- No large-scale architectural refactor of `src/cpp/apps/kano_backlog_cli/main.cpp` into many files as part of this migration convergence plan
- No requirement to delete the Python submodule/reference implementation under `.agents/skills/kano/kano-agent-backlog-skill/src/python/`
- No scope expansion into unrelated feature parity work unless it directly blocks the native active path
- No vague "manual confirmation" acceptance criteria; verification must be agent-executable

---

## Verification Strategy (MANDATORY)

> **ZERO HUMAN INTERVENTION** — ALL verification is agent-executed. No exceptions.

### Test Decision
- **Infrastructure exists**: YES (mostly Python-side)
- **Automated tests**: Tests-after
- **Framework**: Existing pytest on Python side + new native C++ smoke/CTest coverage for convergence work

### QA Policy
Every task must produce evidence under `.sisyphus/evidence/`.

- **Native build / CLI**: Use Bash or interactive shell to build and run `kano-backlog.exe`
- **Native smoke tests**: Use Bash to invoke `ctest` and representative CLI commands
- **Negative checks**: Verify unsupported/legacy Python-only artifacts are not part of normal runtime path
- **Residual policy checks**: Use file reads/searches plus command execution to prove whether a Python file is runtime-critical or not

---

## Execution Strategy

### Parallel Execution Waves

Wave 1 (Start Immediately — proof framework + cleanup policy):
├── Task 1: Native runtime-path audit + command matrix [deep]
├── Task 2: C++ test harness bootstrap in CMake [unspecified-high]
├── Task 3: Build-script parity hardening [quick]
├── Task 4: Repo-root Python artifact classification policy [quick]
└── Task 5: Smoke fixture/evidence scaffolding [quick]

Wave 2 (After Wave 1 — close gaps + add tests):
├── Task 6: Eliminate residual active-path Python dependencies found by audit (depends: 1, 3, 5) [deep]
├── Task 7: Add native smoke coverage for core/admin/config/doctor flows (depends: 2, 5) [unspecified-high]
├── Task 8: Add native smoke coverage for topic/workset/view/search/release representative flows (depends: 2, 5) [unspecified-high]
└── Task 9: Apply repo-root Python cleanup/quarantine rules (depends: 4, 6) [quick]

Wave 3 (After Wave 2 — cutover proof + docs):
├── Task 10: Update runtime-boundary and migration docs (depends: 6, 9) [writing]
└── Task 11: Produce final zero-active-Python proof bundle (depends: 6, 7, 8, 9, 10) [deep]

Wave FINAL (After ALL tasks — independent review, 4 parallel):
├── Task F1: Plan compliance audit (oracle)
├── Task F2: Code quality review (unspecified-high)
├── Task F3: Real manual QA (unspecified-high)
└── Task F4: Scope fidelity check (deep)

Critical Path: Task 1 → Task 6 → Task 11 → F1-F4
Parallel Speedup: ~60% faster than sequential
Max Concurrent: 5

### Dependency Matrix

- **1**: — — 6, 11, 1
- **2**: — — 7, 8, 2
- **3**: — — 6, 1
- **4**: — — 9, 1
- **5**: — — 6, 7, 8, 1
- **6**: 1, 3, 5 — 9, 10, 11, 2
- **7**: 2, 5 — 11, 2
- **8**: 2, 5 — 11, 2
- **9**: 4, 6 — 10, 11, 2
- **10**: 6, 9 — 11, 3
- **11**: 6, 7, 8, 9, 10 — F1-F4, 3

### Agent Dispatch Summary

- **1**: **5** — T1 → `deep`, T2 → `unspecified-high`, T3 → `quick`, T4 → `quick`, T5 → `quick`
- **2**: **4** — T6 → `deep`, T7 → `unspecified-high`, T8 → `unspecified-high`, T9 → `quick`
- **3**: **2** — T10 → `writing`, T11 → `deep`
- **FINAL**: **4** — F1 → `oracle`, F2 → `unspecified-high`, F3 → `unspecified-high`, F4 → `deep`

---

## TODOs

- [ ] 1. Native runtime-path audit + command matrix

  **What to do**:
  - Build the native CLI through `src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh` and identify the exact executable path used for smoke verification.
  - Create a representative command matrix for normal usage: `doctor`, `admin init`, `item/workitem create/read/list/update-state`, `config show/validate`, `view refresh`, `topic create/list/switch`, `workset init/list/next`, and one representative `search` or `release` style command if present.
  - For each command, verify the execution path is native C++ and capture command output as evidence.
  - Identify every remaining case where normal execution still depends on Python at runtime, directly or indirectly.

  **Must NOT do**:
  - Do not broaden this into feature-parity analysis for every niche command.
  - Do not modify the Python submodule as part of the audit.

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: This requires careful runtime-path reasoning across command groups and build outputs.
  - **Skills**: `[]`
  - **Skills Evaluated but Omitted**:
    - `git-master`: No git work required.

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1 (with Tasks 2, 3, 4, 5)
  - **Blocks**: 6, 11
  - **Blocked By**: None

  **References**:
  - `src/cpp/apps/kano_backlog_cli/main.cpp:1-120` - Native CLI entry structure and product-root resolution behavior.
  - `src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh:1-9` - Canonical debug build entrypoint for proof runs.
  - `src/cpp/build/script/common/windows_preset_build.sh:1-42` - Shared Windows build wrapper used by the script.
  - `src/cpp/build/script/common/windows_preset_helper.ps1:15-80` - VS toolchain resolution and configure/build execution path.
  - `build.bat:1-8` - Legacy overlapping build path to compare against the scripted path.

  **Acceptance Criteria**:
  - [ ] A written command matrix exists under `.sisyphus/evidence/` with pass/fail per representative command.
  - [ ] Every audited command records the exact binary path used.
  - [ ] Any residual runtime Python dependency is named with concrete evidence, or the audit explicitly states none were found.

  **QA Scenarios**:
  ```
  Scenario: Happy path native command matrix
    Tool: Bash
    Preconditions: Native debug build completes successfully.
    Steps:
      1. Run `bash src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh`.
      2. Run representative commands using `src/cpp/build/windows-ninja-msvc/kano-backlog.exe`.
      3. Save stdout/stderr for each command into `.sisyphus/evidence/task-1-command-matrix.txt`.
    Expected Result: Representative normal-use commands complete successfully through the native executable.
    Failure Indicators: Command fails, invokes Python, or requires Python-only runtime pieces.
    Evidence: .sisyphus/evidence/task-1-command-matrix.txt

  Scenario: Negative path hidden runtime dependency
    Tool: Bash
    Preconditions: Same native binary available.
    Steps:
      1. Execute the same matrix while explicitly observing invoked paths/process assumptions.
      2. Record any command that still requires Python-hosted behavior.
    Expected Result: No hidden Python runtime dependency for normal command usage, or a concrete blocker list is produced.
    Evidence: .sisyphus/evidence/task-1-runtime-dependency-check.txt
  ```

  **Commit**: NO

- [ ] 2. C++ test harness bootstrap in CMake

  **What to do**:
  - Extend `src/cpp/CMakeLists.txt` to enable native tests and wire a minimal CTest-compatible harness.
  - Create a focused test target strategy for convergence smoke tests rather than exhaustive unit coverage.
  - Ensure the build output supports a deterministic command to run native tests after implementation.

  **Must NOT do**:
  - Do not attempt to port the entire Python test suite.
  - Do not turn this into full framework architecture work.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Build-system modification with native test execution wiring is moderately complex but bounded.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: 7, 8
  - **Blocked By**: None

  **References**:
  - `src/cpp/CMakeLists.txt:1-32` - Current native target graph with no test targets.
  - `tests/test_chunking_mvp.py:1-64` - Example of deterministic behavior-oriented coverage style to emulate conceptually, not port literally.

  **Acceptance Criteria**:
  - [ ] Native test targets are buildable from the project CMake configuration.
  - [ ] A deterministic native test command is documented and runnable.
  - [ ] The test harness is scoped to migration convergence smoke coverage.

  **QA Scenarios**:
  ```
  Scenario: Happy path native test harness runs
    Tool: Bash
    Preconditions: Updated CMake configuration present.
    Steps:
      1. Build with the canonical Windows preset script.
      2. Run `ctest --test-dir src/cpp/build/windows-ninja-msvc --output-on-failure`.
    Expected Result: Native test discovery works and the configured tests run.
    Failure Indicators: No tests discovered, CMake configure failure, or test command crashes.
    Evidence: .sisyphus/evidence/task-2-ctest.txt

  Scenario: Negative path harness scope regression
    Tool: Bash
    Preconditions: Same build tree.
    Steps:
      1. Confirm the harness does not try to execute the old Python pytest suite as part of native verification.
    Expected Result: Native harness remains native-only.
    Evidence: .sisyphus/evidence/task-2-native-only-harness.txt
  ```

  **Commit**: NO

- [ ] 3. Build-script parity hardening

  **What to do**:
  - Compare the current `src/cpp/build/script/` layout against the referenced `kano-git-master-skill` script structure and fill only the gaps required for this repo’s convergence workflow.
  - Remove ambiguity between `build.bat` and the preset-script path by making one canonical and documenting the other as legacy or compatibility-only.
  - Ensure toolchain detection and build output locations are deterministic.

  **Must NOT do**:
  - Do not copy every reference script variant if this repo does not need them.
  - Do not add cross-platform script sprawl without a concrete verification use.

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Script hardening is focused and mostly mechanical once scope is fixed.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: 6
  - **Blocked By**: None

  **References**:
  - `src/cpp/build/script/common/windows_preset_build.sh:1-42` - Current shared wrapper.
  - `src/cpp/build/script/common/windows_preset_helper.ps1:15-80` - Existing VS2022-first resolution logic.
  - `src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh:1-9` - Canonical debug entrypoint.
  - `build.bat:1-8` - Legacy overlapping build path needing explicit disposition.

  **Acceptance Criteria**:
  - [ ] One canonical Windows native build path is clearly established.
  - [ ] Legacy build entrypoints are either aligned, documented, or deprecated.
  - [ ] Evidence shows the canonical path succeeds on the intended environment.

  **QA Scenarios**:
  ```
  Scenario: Happy path canonical Windows build
    Tool: Bash
    Preconditions: PowerShell and VS tools available.
    Steps:
      1. Run `bash src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh`.
      2. Confirm the binary is produced in the documented build directory.
    Expected Result: Canonical build path works without requiring fallback instructions.
    Evidence: .sisyphus/evidence/task-3-build.txt

  Scenario: Negative path legacy-build ambiguity resolved
    Tool: Bash
    Preconditions: Updated scripts/docs available.
    Steps:
      1. Inspect documented build instructions and any retained legacy script entrypoint.
      2. Confirm there is no conflicting “official” Windows build path.
    Expected Result: Canonical-vs-legacy behavior is explicit.
    Evidence: .sisyphus/evidence/task-3-build-policy.txt
  ```

  **Commit**: NO

- [ ] 4. Repo-root Python artifact classification policy

  **What to do**:
  - Inventory repo-root Python artifacts outside `.agents/` and classify each as: remove, replace with native/doc alternative, or retain as explicit non-runtime tooling.
  - Start with `setup.py`, `requirements.txt`, `conftest.py`, `tests/`, and `scripts/verify_config.py` plus `scripts/docs/help/*.py`.
  - Produce a cleanup policy table before deletion or retention decisions are applied.

  **Must NOT do**:
  - Do not classify the `.agents/.../src/python/` reference implementation as in-scope for deletion.
  - Do not keep ambiguous "maybe later" classifications.

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: This is a bounded classification/documentation exercise.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: 9
  - **Blocked By**: None

  **References**:
  - `setup.py:1-40` - Legacy Python packaging surface.
  - `requirements.txt:1-15` - Python dependency declaration.
  - `conftest.py:1-26` - Pytest/Hypothesis test-only config.
  - `tests/test_chunking_mvp.py:1-64` - Example repo-root Python test tied to Python code.
  - `scripts/verify_config.py:1-13` - Python utility script.
  - `scripts/docs/help/` - Python helpers for docs pipeline.

  **Acceptance Criteria**:
  - [ ] Every repo-root Python artifact in scope is classified with a concrete action.
  - [ ] Classification distinguishes active runtime, test-only, docs-only, and legacy/reference roles.
  - [ ] The resulting policy is sufficient to drive Task 9 without ambiguity.

  **QA Scenarios**:
  ```
  Scenario: Happy path classification matrix complete
    Tool: Bash
    Preconditions: File inventory available.
    Steps:
      1. Enumerate in-scope Python artifacts outside `.agents/`.
      2. Produce a classification table with action and rationale.
    Expected Result: No in-scope artifact remains unclassified.
    Evidence: .sisyphus/evidence/task-4-python-classification.md

  Scenario: Negative path hidden residual missed
    Tool: Bash
    Preconditions: Same inventory.
    Steps:
      1. Re-scan the repo-root Python files after classification.
      2. Confirm no in-scope file was omitted from the policy table.
    Expected Result: Classification coverage is exhaustive for the defined scope.
    Evidence: .sisyphus/evidence/task-4-python-classification-check.txt
  ```

  **Commit**: NO

- [ ] 5. Smoke fixture/evidence scaffolding

  **What to do**:
  - Create deterministic smoke inputs/backlog fixtures and evidence-directory conventions used by the remaining migration tasks.
  - Ensure representative commands can be executed against isolated, reproducible local state.
  - Standardize naming for evidence produced by Tasks 1, 6, 7, 8, and 11.

  **Must NOT do**:
  - Do not mix derived evidence with canonical product data without clear separation.

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: This is lightweight scaffolding that unblocks multiple later tasks.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1
  - **Blocks**: 6, 7, 8
  - **Blocked By**: None

  **References**:
  - `.sisyphus/` - Existing evidence-adjacent workspace.
  - `README.md:148-156` - Basic CLI usage examples to model deterministic smoke invocations.

  **Acceptance Criteria**:
  - [ ] Deterministic smoke fixture locations exist and are documented.
  - [ ] Evidence naming is standardized for all downstream tasks.
  - [ ] Downstream tasks can reuse the same fixture root without ad hoc setup.

  **QA Scenarios**:
  ```
  Scenario: Happy path reusable smoke fixture
    Tool: Bash
    Preconditions: Scaffolding files/directories created.
    Steps:
      1. Initialize the smoke fixture state.
      2. Run at least one representative native CLI command against it.
    Expected Result: Fixture is reusable and deterministic.
    Evidence: .sisyphus/evidence/task-5-smoke-fixture.txt

  Scenario: Negative path evidence-path drift
    Tool: Bash
    Preconditions: Same fixture setup.
    Steps:
      1. Verify evidence filenames and directories match the documented convention.
    Expected Result: No ad hoc or inconsistent evidence paths are used.
    Evidence: .sisyphus/evidence/task-5-evidence-policy.txt
  ```

  **Commit**: NO

- [ ] 6. Eliminate residual active-path Python dependencies found by audit

  **What to do**:
  - Use Task 1 findings to remove or replace any remaining normal-use runtime dependency on Python.
  - Prioritize thin-wrapper cutover issues, path-resolution issues, shell-script indirections, or command handlers that still rely on Python-hosted behavior.
  - Re-run the affected smoke matrix immediately after each fix.

  **Must NOT do**:
  - Do not expand into unrelated refactors inside `main.cpp` once the active-path dependency is removed.
  - Do not treat test-only or docs-only Python tooling as runtime blockers.

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: This is the core convergence task and may involve subtle runtime-path issues.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Sequential inside Wave 2
  - **Blocks**: 9, 10, 11
  - **Blocked By**: 1, 3, 5

  **References**:
  - `.sisyphus/evidence/task-1-command-matrix.txt` - Audit source of truth for blocking runtime-path issues.
  - `.sisyphus/evidence/task-1-runtime-dependency-check.txt` - Negative-check evidence to resolve.
  - `src/cpp/apps/kano_backlog_cli/main.cpp:1-120` and relevant later command sections - Native command handling entrypoints.

  **Acceptance Criteria**:
  - [ ] Every runtime blocker found in Task 1 is either fixed or explicitly proven non-blocking to normal usage.
  - [ ] Re-run evidence shows the previously failing command path is now native-only.
  - [ ] No new runtime Python dependency is introduced by the fixes.

  **QA Scenarios**:
  ```
  Scenario: Happy path blocker removed
    Tool: Bash
    Preconditions: At least one blocker identified by Task 1.
    Steps:
      1. Apply the fix for the blocker.
      2. Rebuild using the canonical Windows script.
      3. Re-run the affected command(s).
    Expected Result: Previously blocked command now completes through the native runtime path.
    Evidence: .sisyphus/evidence/task-6-blocker-fix.txt

  Scenario: Negative path regression after cutover
    Tool: Bash
    Preconditions: Updated native path available.
    Steps:
      1. Re-run the broader command matrix after targeted fixes.
      2. Confirm no unrelated command regressed into failure or Python dependence.
    Expected Result: Cutover fixes do not create new active-path regressions.
    Evidence: .sisyphus/evidence/task-6-regression-check.txt
  ```

  **Commit**: NO

- [ ] 7. Add native smoke coverage for core/admin/config/doctor flows

  **What to do**:
  - Add targeted native tests for the highest-value foundational flows: build sanity, `doctor`, `admin init`, item/workitem basics, and config inspection/validation.
  - Keep the tests deterministic and narrow enough to support tests-after convergence verification.

  **Must NOT do**:
  - Do not duplicate the entire Python CLI test style one-for-one.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Moderate implementation/testing work with multiple representative flows.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2 (with Tasks 8, 9 after dependencies)
  - **Blocks**: 11
  - **Blocked By**: 2, 5

  **References**:
  - `src/cpp/CMakeLists.txt:1-32` - Test harness integration point.
  - `README.md:148-156` - Core CLI verification examples.
  - `src/cpp/apps/kano_backlog_cli/main.cpp:1-120` - Shared command parsing/helpers.

  **Acceptance Criteria**:
  - [ ] Native smoke tests cover foundational normal-use flows.
  - [ ] Tests run through the documented native test command.
  - [ ] Failures are reported in a way suitable for automated verification.

  **QA Scenarios**:
  ```
  Scenario: Happy path foundational smoke tests pass
    Tool: Bash
    Preconditions: Native test harness available.
    Steps:
      1. Build the project.
      2. Run native tests covering `doctor`, `admin init`, item/workitem basics, and config flows.
    Expected Result: Foundational smoke tests pass.
    Evidence: .sisyphus/evidence/task-7-foundational-smoke.txt

  Scenario: Negative path foundational command failure surfaces correctly
    Tool: Bash
    Preconditions: Native tests present.
    Steps:
      1. Trigger at least one invalid-input branch in a foundational command test.
      2. Confirm failure is surfaced deterministically.
    Expected Result: Negative-path behavior is tested and produces predictable results.
    Evidence: .sisyphus/evidence/task-7-foundational-negative.txt
  ```

  **Commit**: NO

- [ ] 8. Add native smoke coverage for topic/workset/view/search/release representative flows

  **What to do**:
  - Add representative native smoke tests for higher-level workflows that exercise the more complex command families without attempting exhaustive coverage.
  - Focus on commands that best prove the active path remains native under realistic usage.

  **Must NOT do**:
  - Do not attempt exhaustive semantic parity for every experimental feature.
  - Do not create flaky tests that depend on external services.

  **Recommended Agent Profile**:
  - **Category**: `unspecified-high`
    - Reason: Broader command-family coverage with more complex fixture needs.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: 11
  - **Blocked By**: 2, 5

  **References**:
  - `README.md` topic/workset examples and product workflow descriptions.
  - `src/cpp/apps/kano_backlog_cli/main.cpp` relevant command-family sections.

  **Acceptance Criteria**:
  - [ ] Native smoke tests cover representative topic/workset/view/search/release flows.
  - [ ] At least one negative/edge case exists for each tested command family.
  - [ ] Tests remain deterministic in local-only execution.

  **QA Scenarios**:
  ```
  Scenario: Happy path advanced representative smoke tests pass
    Tool: Bash
    Preconditions: Fixture scaffolding from Task 5 available.
    Steps:
      1. Run native tests or smoke commands for representative topic/workset/view/search/release flows.
      2. Capture outputs and assertions.
    Expected Result: Representative advanced flows succeed natively.
    Evidence: .sisyphus/evidence/task-8-advanced-smoke.txt

  Scenario: Negative path advanced-flow invalid input
    Tool: Bash
    Preconditions: Same fixture root.
    Steps:
      1. Run a topic/workset/search/release command with intentionally invalid or missing input.
      2. Confirm error handling is deterministic and documented.
    Expected Result: Errors fail cleanly without invoking Python fallback behavior.
    Evidence: .sisyphus/evidence/task-8-advanced-negative.txt
  ```

  **Commit**: NO

- [ ] 9. Apply repo-root Python cleanup/quarantine rules

  **What to do**:
  - Execute the policy from Task 4: remove unnecessary repo-root Python artifacts, replace them where needed, and explicitly quarantine retained non-runtime Python tooling.
  - Ensure deleted/replaced files do not break the now-native convergence workflow.
  - If docs-only Python tooling remains, label it clearly as non-runtime.

  **Must NOT do**:
  - Do not touch `.agents/skills/kano/kano-agent-backlog-skill/src/python/`.
  - Do not remove docs-tooling or test-tooling blindly without checking whether it still serves a valid non-runtime purpose.

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: This is cleanup guided by a precomputed policy table.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2
  - **Blocks**: 10, 11
  - **Blocked By**: 4, 6

  **References**:
  - `.sisyphus/evidence/task-4-python-classification.md` - Cleanup policy source of truth.
  - `setup.py:1-40`, `requirements.txt:1-15`, `conftest.py:1-26`, `scripts/verify_config.py:1-13` - Initial cleanup targets.
  - `scripts/docs/help/` - Potential retained docs-only Python helper scope.

  **Acceptance Criteria**:
  - [ ] All in-scope repo-root Python artifacts match the approved classification outcome.
  - [ ] Removed files are no longer referenced by active runtime/build/test instructions.
  - [ ] Retained Python artifacts are explicitly justified as non-runtime.

  **QA Scenarios**:
  ```
  Scenario: Happy path cleanup policy applied
    Tool: Bash
    Preconditions: Classification policy complete.
    Steps:
      1. Apply removal/replacement/quarantine actions.
      2. Re-run the native build and representative CLI smoke commands.
    Expected Result: Cleanup does not break the native convergence workflow.
    Evidence: .sisyphus/evidence/task-9-cleanup.txt

  Scenario: Negative path stale reference after cleanup
    Tool: Bash
    Preconditions: Cleanup applied.
    Steps:
      1. Search build/test/docs instructions for references to removed runtime-relevant Python files.
      2. Confirm no stale dependency remains.
    Expected Result: No broken references to removed repo-root Python artifacts remain in the active path.
    Evidence: .sisyphus/evidence/task-9-stale-reference-check.txt
  ```

  **Commit**: NO

- [ ] 10. Update runtime-boundary and migration docs

  **What to do**:
  - Update repo documentation so it clearly states the new runtime boundary: normal `kano-backlog` execution is native C++, while any retained Python is legacy/reference/docs-only scope.
  - Update build and verification instructions to point to the canonical native path.
  - Document the residual legacy boundary explicitly so future agents do not reopen migration ambiguity.

  **Must NOT do**:
  - Do not leave mixed messaging that still implies Python is required for ordinary CLI use.

  **Recommended Agent Profile**:
  - **Category**: `writing`
    - Reason: This is primarily documentation clarification and migration messaging.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 3
  - **Blocks**: 11
  - **Blocked By**: 6, 9

  **References**:
  - `README.md:128-156` - Existing install/verify instructions still mention Python-centric setup.
  - `build.bat:1-8` and `src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh:1-9` - Build-path messaging to reconcile.

  **Acceptance Criteria**:
  - [ ] Docs clearly identify native C++ as the normal runtime path.
  - [ ] Docs explicitly classify retained Python as non-runtime where applicable.
  - [ ] Build and verification instructions reference the canonical native path.

  **QA Scenarios**:
  ```
  Scenario: Happy path docs match native runtime
    Tool: Bash
    Preconditions: Documentation updates complete.
    Steps:
      1. Read the updated runtime/build sections.
      2. Follow the documented native build and verification steps exactly.
    Expected Result: Documentation is sufficient to reproduce the native workflow without Python runtime assumptions.
    Evidence: .sisyphus/evidence/task-10-docs-verification.txt

  Scenario: Negative path contradictory runtime messaging
    Tool: Bash
    Preconditions: Updated docs available.
    Steps:
      1. Search docs for statements implying Python is required for ordinary `kano-backlog` runtime use.
    Expected Result: No contradictory messaging remains in the updated scope.
    Evidence: .sisyphus/evidence/task-10-docs-contradiction-check.txt
  ```

  **Commit**: NO

- [ ] 11. Produce final zero-active-Python proof bundle

  **What to do**:
  - Assemble the final evidence bundle demonstrating that ordinary `kano-backlog` usage is fully native.
  - Include command-matrix outputs, native build/test outputs, residual Python classification, cleanup result, and docs verification.
  - Write an explicit final verdict summarizing what Python remains and why it does not violate the active-path goal.

  **Must NOT do**:
  - Do not claim full submodule-wide Python removal.
  - Do not omit residual exceptions; state them explicitly.

  **Recommended Agent Profile**:
  - **Category**: `deep`
    - Reason: This is the synthesis/proof task that determines whether convergence is actually achieved.
  - **Skills**: `[]`

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Sequential end of Wave 3
  - **Blocks**: F1, F2, F3, F4
  - **Blocked By**: 6, 7, 8, 9, 10

  **References**:
  - `.sisyphus/evidence/task-1-command-matrix.txt`
  - `.sisyphus/evidence/task-2-ctest.txt`
  - `.sisyphus/evidence/task-4-python-classification.md`
  - `.sisyphus/evidence/task-9-cleanup.txt`
  - `.sisyphus/evidence/task-10-docs-verification.txt`

  **Acceptance Criteria**:
  - [ ] Final evidence bundle states whether the active-path goal is achieved.
  - [ ] Residual Python files are explicitly listed with rationale and classification.
  - [ ] Evidence demonstrates native build, native tests, and native command-matrix success.

  **QA Scenarios**:
  ```
  Scenario: Happy path final proof bundle complete
    Tool: Bash
    Preconditions: All prior tasks complete.
    Steps:
      1. Collect all evidence artifacts into the final proof bundle.
      2. Verify each referenced evidence file exists.
      3. Write the final convergence verdict.
    Expected Result: A reviewer can determine from the bundle that normal `kano-backlog` runtime is native-only.
    Evidence: .sisyphus/evidence/task-11-final-proof.md

  Scenario: Negative path unsupported completion claim
    Tool: Bash
    Preconditions: Final proof draft prepared.
    Steps:
      1. Check that every claim in the final verdict cites an evidence artifact.
      2. Flag any unsupported assertion.
    Expected Result: No unsupported claim remains in the final proof bundle.
    Evidence: .sisyphus/evidence/task-11-proof-audit.txt
  ```

  **Commit**: NO

---

## Final Verification Wave (MANDATORY — after ALL implementation tasks)

> 4 review agents run in PARALLEL. ALL must APPROVE. Rejection → fix → re-run.

- [ ] F1. **Plan Compliance Audit** — `oracle`
  Verify every must-have and must-not-have against actual files, commands, and evidence under `.sisyphus/evidence/`. Confirm the final runtime-path proof explicitly demonstrates normal `kano-backlog` usage is native.
  Output: `Must Have [N/N] | Must NOT Have [N/N] | Tasks [N/N] | VERDICT: APPROVE/REJECT`

- [ ] F2. **Code Quality Review** — `unspecified-high`
  Run native build, lint/compile equivalents available in the repo, and all new smoke/CTest suites. Inspect touched files for brittle path handling, hidden Python-shell assumptions, dead cleanup logic, and undocumented behavior changes.
  Output: `Build [PASS/FAIL] | Tests [N pass/N fail] | Files [N clean/N issues] | VERDICT`

- [ ] F3. **Real Manual QA** — `unspecified-high`
  From a clean state, execute the exact CLI smoke matrix, capture outputs, and confirm the documented residual Python files are not required for normal CLI invocation.
  Output: `Scenarios [N/N pass] | Integration [N/N] | Residual Checks [N/N] | VERDICT`

- [ ] F4. **Scope Fidelity Check** — `deep`
  Compare the actual diff against this plan. Reject if the work expanded into broad architectural refactors, submodule-wide Python removal, or unrelated feature parity work.
  Output: `Tasks [N/N compliant] | Contamination [CLEAN/N issues] | Unaccounted [CLEAN/N files] | VERDICT`

---

## Commit Strategy

> Only create commits if a human explicitly asks.

- **Commit Group 1**: native build/test harness foundation
  - Proposed message: `KABSD-TSK-0373: harden native build and smoke harness`
- **Commit Group 2**: active-path cleanup and runtime proof
  - Proposed message: `KABSD-TSK-0373 KABSD-TSK-0374: remove residual python runtime paths`
- **Commit Group 3**: docs and residual-boundary updates
  - Proposed message: `KABSD-TSK-0373: document native runtime boundary`

---

## Success Criteria

### Verification Commands
```bash
bash src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh
src/cpp/build/windows-ninja-msvc/kano-backlog.exe doctor
ctest --test-dir src/cpp/build/windows-ninja-msvc --output-on-failure
```

### Final Checklist
- [ ] All "Must Have" items are present
- [ ] All "Must NOT Have" items are absent
- [ ] Native smoke/build verification passes
- [ ] Repo-root Python residue is explicitly classified and justified
- [ ] Normal `kano-backlog` runtime path is proven native-only
