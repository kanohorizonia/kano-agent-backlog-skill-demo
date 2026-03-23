# Kob Tokenizer Docs Cleanup

## Scope

Updated the packaged tokenizer docs to the current `kob` command surface and removed stale tokenizer subcommand names from active guidance.

## Updated files

- `.agents/skills/kano/kano-agent-backlog-skill/docs/tokenizer-quickstart.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/tokenizer-cli-reference.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/tokenizer-troubleshooting.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/tokenizer-adapters.md`

## Key fixes

- `kano-backlog` -> `kob`
- `tokenizer compare` -> `tokenizer benchmark`
- `tokenizer diagnose` -> `tokenizer adapter-status`
- `tokenizer env` -> `tokenizer env-vars`
- `tokenizer health` -> `tokenizer health-check`
- benchmark examples updated to commands confirmed by the current native CLI

## Verification

- `bash kob tokenizer benchmark`
- `bash kob tokenizer adapter-status`
- `bash kob tokenizer env-vars`
- `bash kob tokenizer health-check`
- post-cleanup scan confirms the targeted stale tokenizer command names are gone from the updated docs
