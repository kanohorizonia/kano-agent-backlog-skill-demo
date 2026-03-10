# C++ Runtime Architecture (Python Elimination)

## Module Decomposition

```mermaid
flowchart TD
    CLI[apps/kano_backlog_cli]\n+    OPS[systems/backlog_ops]\n+    CORE[systems/backlog_core]\n+    ADAPT[systems/backlog_adapters]\n+    SHARED[systems/backlog_shared]\n+
    CLI --> OPS
    OPS --> CORE
    OPS --> ADAPT
    ADAPT --> CORE
    CORE --> SHARED
    OPS --> SHARED
    ADAPT --> SHARED
```

## Physical Layout

- `src/cpp/apps/kano_backlog_cli/`
  - Command registration and argument parsing.
  - Text/json output formatting.
  - Exit code policy.
- `src/cpp/systems/backlog_ops/`
  - Use-cases: `workitem`, `topic`, `workset`, `view`, `worklog`, `adr`, `search`.
  - No direct file/sql parsing logic inside use-cases.
- `src/cpp/systems/backlog_core/`
  - Domain models (`BacklogItem`, states, IDs).
  - Frontmatter/markdown canonical read-write rules.
  - Validation and ready-gate rules.
  - Error taxonomy.
- `src/cpp/systems/backlog_adapters/`
  - Filesystem repository adapter.
  - SQLite index/sequence adapter.
  - VCS adapter (git/null).
  - Config loading adapter.
- `src/cpp/systems/backlog_shared/`
  - Utilities: clock, uuid, path helpers, serialization helpers.

## Dependency Rules

- `apps -> ops -> core` is the primary flow.
- `ops` can call `adapters` only through adapter interfaces.
- `core` must not depend on CLI or concrete adapter implementations.
- `adapters` can depend on `core` contracts but not `apps`.
- No cross-import from `apps` into `systems/*`.

## Python-to-C++ Mapping

- `src/python/kano_backlog_core/*` -> `src/cpp/systems/backlog_core/*`
- `src/python/kano_backlog_ops/*` -> `src/cpp/systems/backlog_ops/*`
- `src/python/kano_backlog_cli/*` -> `src/cpp/apps/kano_backlog_cli/*`
- Python external integration points (sqlite/vcs/fs/config) -> `src/cpp/systems/backlog_adapters/*`

## Initial Submodules To Create

- `backlog_core/model/`
- `backlog_core/state/`
- `backlog_core/frontmatter/`
- `backlog_core/validation/`
- `backlog_core/errors/`
- `backlog_ops/workitem/`
- `backlog_ops/topic/`
- `backlog_ops/workset/`
- `backlog_ops/view/`
- `backlog_adapters/fs/`
- `backlog_adapters/sqlite/`
- `backlog_adapters/vcs/`
- `apps/kano_backlog_cli/commands/`

## Migration Sequence By Module

1. `backlog_core` (model/state/frontmatter/validation).
2. `backlog_adapters/fs` + `backlog_adapters/sqlite` primitives.
3. `backlog_ops/workitem` and `backlog_ops/worklog`.
4. `backlog_ops/topic` and `backlog_ops/workset`.
5. `backlog_ops/view` and remaining secondary ops.
6. `apps/kano_backlog_cli` full command cutover.
7. Remove Python runtime path and packaging entrypoints.
