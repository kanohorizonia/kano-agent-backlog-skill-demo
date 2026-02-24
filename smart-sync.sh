#!/usr/bin/env bash
#
# smart-sync.sh - Project-level fast sync entrypoint

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIG_ARGS=("$@")
source "$ROOT/smart-wrapper-common.sh"

resolve_sync_script_dir() {
  local skill_root
  if skill_root="$(resolve_git_master_skill_root "$ROOT" 2>/dev/null)"; then
    printf '%s/scripts/commit-tools/sync' "$skill_root"
    return 0
  fi
  printf '%s/.agents/skills/kano/kano-git-master-skill/scripts/commit-tools/sync' "$ROOT"
}

usage() {
  cat <<'USAGE'
Usage: ./smart-sync.sh [origin-latest] [args...]

Examples:
  ./smart-sync.sh
  ./smart-sync.sh origin-latest

Advanced operations are intentionally not routed by this wrapper.
Use dedicated scripts directly when needed:
  ./.agents/kano/kano-git-master-skill/scripts/commit-tools/sync/smart-sync-dev.sh ...
  ./.agents/kano/kano-git-master-skill/scripts/commit-tools/sync/smart-sync-upstream-force-push-copilot.sh ...
USAGE
}

run_skill_script() {
  local script_rel="$1"
  shift || true
  local script_dir
  script_dir="$(resolve_sync_script_dir)"
  local script="$script_dir/$script_rel"
  ensure_skill_script_exists "$script"
  run_skill_script_from_root "$ROOT" "$script" "$@"
}

ensure_git_master_skill_ready() {
  local skill_script_dir
  skill_script_dir="$(resolve_sync_script_dir)"
  if [[ -d "$skill_script_dir" ]]; then
    return 0
  fi

  echo "[smart-sync] kano-git-master-skill not found, bootstrapping submodules..." >&2
  (
    cd "$ROOT"
    git submodule init
    git submodule sync --recursive
    git submodule update --init --recursive
  )

  skill_script_dir="$(resolve_sync_script_dir)"
  if [[ ! -d "$skill_script_dir" ]]; then
    echo "ERROR: kano-git-master-skill is still unavailable after submodule bootstrap." >&2
    echo "Expected directory: $skill_script_dir" >&2
    exit 1
  fi
}

first_arg="${1:-}"
if [[ "$first_arg" == "-h" || "$first_arg" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "$first_arg" == "origin-latest" ]]; then
  shift
elif [[ -n "$first_arg" ]]; then
  case "$first_arg" in
    upstream-stable-dev|stable-dev|dev|upstream-force-push)
      echo "ERROR: '$first_arg' is an advanced mode and is not handled by ./smart-sync.sh." >&2
      usage >&2
      exit 1
      ;;
  esac
fi

ensure_git_master_skill_ready
set +e
run_skill_script "smart-sync-origin-latest.sh" "$@"
status=$?
set -e
pause_if_needed "${ORIG_ARGS[@]}"
exit "$status"
