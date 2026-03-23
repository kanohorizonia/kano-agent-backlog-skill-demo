# Kob Branding Promotion

## Scope

Promoted `kob` from a short alias to the primary local command surface in the main repo docs and command examples.

## Updated files

- `README.md`
  - local quick-start now uses `kob`
  - kob helper section remains primary
  - workset/topic/manual command examples now use `kob`
  - troubleshooting local command example now uses `kob`

- `docs/index.md`
  - quick-start already used `kob`; kept aligned with the new helper surface

## Verification

- `bash kob`
- `bash kob doctor`
- `bash scripts/internal/show-version.sh`

## Notes

- Historical mentions of `kano-backlog` may still remain in legacy/reference materials outside the primary repo-local quick-start path.
- This change is about the preferred local surface, not about erasing every historical name in all archived docs.
