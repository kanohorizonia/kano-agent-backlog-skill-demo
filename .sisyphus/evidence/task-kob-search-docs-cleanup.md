# Kob Search And Experimental Docs Cleanup

## Scope

Updated active packaged experimental/search docs so they use the current `kob` command surface and avoid stale search/tokenizer command names.

## Updated files

- `.agents/skills/kano/kano-agent-backlog-skill/docs/experimental-features.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/multi-corpus-search.md`
- `.agents/skills/kano/kano-agent-backlog-skill/docs/search-performance-comparison.md`

## Key fixes

- `kano-backlog` -> `kob`
- `search semantic` -> `search hybrid`
- `item query --filter` -> `item list`
- `tokenizer diagnose` -> `tokenizer adapter-status`

## Verification

- `bash kob search hybrid "embed" --corpus repo --k 10 --fts-k 20`
- `bash kob chunks build-repo`
- `bash kob tokenizer adapter-status`
- post-cleanup scan confirms the targeted stale forms are gone from the updated files
