# Kob Final Active Docs Cleanup

## Scope

Removed the last material active-doc command mismatches found by the final local sweep.

## Updated files

- `docs/configuration.md`
- `docs/installation.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/publishing-to-pypi.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/tokenizer-configuration.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/tokenizer-performance.md`

## Key fixes

- `kob backlog init` -> `kob admin init`
- `kob --version` -> `bash scripts/internal/show-version.sh`
- remaining `kano-backlog` current-use examples -> `kob`
- stale tokenizer command names normalized to `benchmark`, `adapter-status`, `env-vars`, and `health-check`

## Verification

- static scan confirms the targeted stale forms are gone from the updated files
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`
- `bash kob tokenizer benchmark`
- `bash kob tokenizer env-vars`

## Conclusion

No equally material current-surface command mismatches remain in the targeted active docs cluster after this pass.
