# C++ Migration Plan: Remove Python Runtime

## Scope

- In scope: runtime implementation currently under `.agents/skills/kano/kano-agent-backlog-skill/src/python/`.
- Out of scope: temporary dev scripts that are not part of production runtime execution.

## Target Architecture

- `src/cpp/systems/backlog_core/`: models, state machine, frontmatter/schema parsing, validation, deterministic serialization.
- `src/cpp/systems/backlog_ops/`: workitem/topic/workset/view/adr orchestration and use-cases.
- `src/cpp/systems/backlog_adapters/`: filesystem, sqlite, vcs/git, config, clock/uuid.
- `src/cpp/apps/kano_backlog_cli/`: command routing, argument parsing, output formatting, exit codes.

## Migration Strategy

1. Define compatibility contract (commands, output shape, side effects, error behavior).
2. Build parity test harness with golden fixtures and deterministic assertions.
3. Port core modules first and pass core invariants.
4. Port ops modules in prioritized order (workitem/topic/workset/view first).
5. Replace Python CLI path with native C++ CLI binary.
6. Run full parity gate and remove Python runtime path and packaging.

## Compatibility Contract

- Preserve canonical markdown and frontmatter structure.
- Preserve worklog append-only behavior and timestamp format.
- Preserve item/UID resolution behavior and sequence synchronization semantics.
- Preserve command-level UX for high-frequency workflows.
- Record intentional breaking changes explicitly (pre-alpha policy).

## Validation Gates

- Gate A (Architecture): module mapping complete, no orphan Python runtime module without C++ owner.
- Gate B (Core parity): parser/serializer/validation parity passes on fixture corpus.
- Gate C (Ops parity): critical workflows pass deterministic compare.
- Gate D (CLI parity): command invocation and output contract pass matrix scenarios.
- Gate E (Decommission): Python runtime path no longer required for execution.

## Risks and Mitigations

- Parsing drift in frontmatter/markdown formatting -> golden fixtures + strict compare.
- Behavior drift in edge-case commands -> explicit parity matrix + regression scenarios.
- Rewrite scope creep -> phase-based acceptance gates and backlog hierarchy.
- Build/toolchain friction -> lock CMake presets and CI parity jobs early.

## Deliverables

- Architecture mapping table and contract matrix.
- Parity harness and fixture corpus.
- C++ runtime implementation across core/ops/cli/adapters.
- Python runtime decommission checklist and completion report.
