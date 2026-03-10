# Topic Brief: cpp-migration-python-elimination

Generated: 2026-03-05T18:00:26.664234Z

## Facts

<!-- Verified facts with citations to materials/items/docs -->
- Runtime migration scope is `.agents/skills/kano/kano-agent-backlog-skill/src/python/`, and the target is full C++ runtime replacement.
- Migration epic and child features/tasks are created and linked under `KABSD-EPIC-0018`.
- Formal migration plan artifact is attached: `_kano/backlog/_shared/artifacts/KABSD-EPIC-0018/cpp-migration-python-elimination-plan.md`.
- C++ module decomposition and placement diagram is attached: `_kano/backlog/_shared/artifacts/KABSD-FTR-0067/cpp-runtime-architecture.md`.

## Unknowns / Risks

<!-- Open questions and potential blockers -->
- Potential behavior drift in frontmatter/markdown serialization and command output formatting.
- Toolchain and packaging cutover risk when removing Python execution path.

## Proposed Actions

<!-- Concrete next steps, linked to workitems -->
- Complete module inventory and ownership mapping (`KABSD-TSK-0371`).
- Define CLI compatibility matrix (`KABSD-TSK-0369`) and parity harness (`KABSD-TSK-0370`).
- Execute phased C++ migration tasks (`KABSD-TSK-0374`, `KABSD-TSK-0375`, `KABSD-TSK-0373`).
- Decommission Python runtime only after parity pass (`KABSD-TSK-0372`).

## Decision Candidates

<!-- Tradeoffs requiring ADR -->
- Decide strict CLI parity versus deliberate pre-alpha command surface cleanup (ADR candidate).
- Decide serializer normalization policy for markdown/frontmatter (ADR candidate).

---
_This brief is human-maintained. `topic distill` writes to `brief.generated.md`._
