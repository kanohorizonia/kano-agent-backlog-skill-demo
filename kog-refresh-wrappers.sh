#!/usr/bin/env bash
#
# kog-refresh-wrappers.sh - Refresh root kog wrappers from kano-git-master-skill templates

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE=""
TARGET="$ROOT"
FORCE=1
EXTRA_ARGS=()
PROFILE_STATE_FILE="$ROOT/.kog-wrapper-profile"

usage() {
  cat <<'USAGE'
Usage: kog-refresh-wrappers.sh [options]

Options:
  --profile <name>      Wrapper profile (default: oss)
  --target <dir>        Target directory (default: current repo root)
  --no-force            Do not overwrite existing wrappers
  --dry-run             Preview actions only
  -h, --help            Show help

Examples:
  ./kog-refresh-wrappers.sh
  ./kog-refresh-wrappers.sh --profile standalone
  ./kog-refresh-wrappers.sh --dry-run
USAGE
}

resolve_git_master_skill_root() {
  local root="$1"
  local candidate
  local candidates=(
    "$root/.agents/skills/kano/kano-git-master-skill"
    "$root/.agents/kano/kano-git-master-skill"
    "$root/skills/kano/kano-git-master-skill"
    "$root/skills/kano-git-master-skill"
  )

  for candidate in "${candidates[@]}"; do
    if [[ -d "$candidate" ]]; then
      printf '%s' "$candidate"
      return 0
    fi
  done

  return 1
}

resolve_generator_script() {
  local skill_root="$1"
  local candidate
  local candidates=(
    "$skill_root/src/shell/core/gen-root-wrappers.sh"
    "$skill_root/scripts/core/gen-root-wrappers.sh"
  )

  for candidate in "${candidates[@]}"; do
    if [[ -f "$candidate" ]]; then
      printf '%s' "$candidate"
      return 0
    fi
  done

  return 1
}

is_valid_profile() {
  local profile="$1"
  case "$profile" in
    standalone|oss|repo-passive-mode|repo-passive-mode-with-ai)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

infer_profile_from_root() {
  if [[ -n "${KOG_WRAPPER_PROFILE:-}" ]]; then
    printf '%s' "$KOG_WRAPPER_PROFILE"
    return 0
  fi

  if [[ -f "$PROFILE_STATE_FILE" ]]; then
    local remembered
    remembered="$(sed -n '1p' "$PROFILE_STATE_FILE" | tr -d '[:space:]')"
    if is_valid_profile "$remembered"; then
      printf '%s' "$remembered"
      return 0
    fi
  fi

  if [[ -f "$ROOT/kog-sync-upstream-stable-dev.sh" ]]; then
    printf '%s' "oss"
    return 0
  fi

  printf '%s' "standalone"
}

pause_if_needed() {
  [[ "${CI:-}" == "1" || "${CI:-}" == "true" ]] && return 0
  [[ "${KANO_AGENT_MODE:-}" == "1" || "${KANO_AGENT_MODE:-}" == "true" ]] && return 0
  local pause_timeout="${KOG_WRAPPER_PAUSE_TIMEOUT:-10}"
  if [[ "$pause_timeout" =~ ^[0-9]+$ ]] && [[ "$pause_timeout" -gt 0 ]]; then
    if ! read -r -t "$pause_timeout" -p "Press Enter to continue... (auto-continue in ${pause_timeout}s) "; then
      echo ""
    fi
  else
    read -r -p "Press Enter to continue..."
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      [[ $# -ge 2 ]] || { echo "ERROR: --profile requires a value" >&2; exit 1; }
      PROFILE="$2"
      shift 2
      ;;
    --target)
      [[ $# -ge 2 ]] || { echo "ERROR: --target requires a value" >&2; exit 1; }
      TARGET="$2"
      shift 2
      ;;
    --no-force)
      FORCE=0
      shift
      ;;
    --dry-run)
      EXTRA_ARGS+=("--dry-run")
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$PROFILE" ]]; then
  PROFILE="$(infer_profile_from_root)"
fi

if ! is_valid_profile "$PROFILE"; then
  echo "ERROR: Unsupported profile: $PROFILE" >&2
  exit 1
fi

SKILL_ROOT="$(resolve_git_master_skill_root "$ROOT")" || {
  echo "ERROR: kano-git-master-skill root not found under $ROOT" >&2
  exit 1
}

GENERATOR="$(resolve_generator_script "$SKILL_ROOT")" || {
  echo "ERROR: gen-root-wrappers.sh not found in skill root: $SKILL_ROOT" >&2
  exit 1
}

ARGS=("--profile" "$PROFILE" "--target" "$TARGET")
if [[ "$FORCE" -eq 1 ]]; then
  ARGS+=("--force")
fi
ARGS+=("${EXTRA_ARGS[@]}")

echo "[kog-refresh-wrappers] profile=$PROFILE target=$TARGET force=$FORCE"
set +e
bash "$GENERATOR" "${ARGS[@]}"
status=$?
set -e

if [[ "$status" -eq 0 ]]; then
  printf '%s\n' "$PROFILE" > "$PROFILE_STATE_FILE"
fi

pause_if_needed
exit "$status"
