# Repo-Root Python Classification

## Runtime-Relevant Or Previously Runtime-Adjacent

- `.agents/skills/kano/kano-agent-backlog-skill/scripts/kano-backlog`
  - Status: converted to bash native launcher
  - Impact: no longer requires Python for wrapper-based local execution
  - Action: keep as native shim pointing at `src/cpp/build/windows-ninja-msvc/kano-backlog.exe`

- `.agents/skills/kano/kano-agent-backlog-skill/scripts/kano-backlog.bat`
  - Status: added Windows native launcher
  - Impact: removes Python from wrapper-based local execution on Windows
  - Action: keep as native shim pointing at `src/cpp/build/windows-ninja-msvc/kano-backlog.exe`

## Non-Runtime Test Or Tooling Residue

- `tests/`
  - Status: removed
  - Impact: not required for normal native `kano-backlog` execution
  - Action: deleted after native CTest coverage replaced the active local verification path

- `conftest.py`
  - Status: removed
  - Impact: not required for normal native runtime
  - Action: deleted with the retired repo-root Python test suite

- `setup.py`
  - Status: removed
  - Impact: not required for local native CLI execution
  - Action: deleted as redundant repo-root Python packaging residue

- `requirements.txt`
  - Status: removed
  - Impact: not required for local native CLI execution
  - Action: deleted as redundant repo-root Python dependency residue

- `scripts/verify_config.py`
  - Status: removed
  - Impact: not part of the normal native CLI path
  - Action: deleted as non-runtime Python residue

- `scripts/docs/help/*.py`
  - Status: docs pipeline helpers
  - Impact: docs-only, not runtime-critical for `kano-backlog`
  - Action: retain as docs tooling unless docs pipeline is migrated separately

## Active Local Convergence Direction

- `kano-backlog`
  - Status: repo-root bash launcher to native binary
  - Impact: provides a non-Python local entrypoint for normal repo usage

- `kano-backlog.bat`
  - Status: repo-root Windows launcher to native binary
  - Impact: provides a non-Python local entrypoint for normal repo usage on Windows
