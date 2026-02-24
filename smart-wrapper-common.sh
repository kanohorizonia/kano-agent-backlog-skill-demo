#!/usr/bin/env bash
#
# smart-wrapper-common.sh - Shared helpers for root wrapper templates.

set -euo pipefail

resolve_git_master_skill_root() {
  local root="$1"
  local candidate=""
  local candidates=(
    "$root/.agents/skills/kano/kano-git-master-skill"
    "$root/.agents/kano/kano-git-master-skill"
  )

  for candidate in "${candidates[@]}"; do
    if [[ -d "$candidate" ]]; then
      printf '%s' "$candidate"
      return 0
    fi
  done

  echo "ERROR: kano-git-master-skill submodule path not found under $root" >&2
  echo "Tried:" >&2
  echo "  $root/.agents/skills/kano/kano-git-master-skill" >&2
  echo "  $root/.agents/kano/kano-git-master-skill" >&2
  return 1
}

resolve_skill_script_path() {
  local root="$1"
  local rel_path="$2"
  local skill_root

  skill_root="$(resolve_git_master_skill_root "$root")" || return 1
  printf '%s/%s' "$skill_root" "$rel_path"
}

ensure_skill_script_exists() {
  local script="$1"
  if [[ -f "$script" ]]; then
    return 0
  fi
  echo "ERROR: Git Master Skill script not found at:" >&2
  echo "  $script" >&2
  echo "Ensure the kano-git-master-skill submodule is initialized." >&2
  return 1
}

has_arg() {
  local needle="$1"
  shift
  local arg=""
  for arg in "$@"; do
    if [[ "$arg" == "$needle" ]]; then
      return 0
    fi
  done
  return 1
}

run_skill_script_from_root() {
  local root="$1"
  local script="$2"
  shift 2 || true

  export KANO_GIT_MASTER_ROOT="$root"
  (
    cd "$root"
    bash "$script" "$@"
  )
}

pause_if_needed() {
  # Pause only for interactive human runs.
  [[ -t 0 && -t 1 ]] || return 0
  [[ "${CI:-}" == "1" || "${CI:-}" == "true" ]] && return 0

  local args=("$@")
  local i=0
  local arg=""
  local agent=""
  for ((i=0; i<${#args[@]}; i++)); do
    arg="${args[$i]}"
    case "$arg" in
      --agent)
        if [[ $((i+1)) -lt ${#args[@]} ]]; then
          agent="${args[$((i+1))]}"
        fi
        ;;
      --agent=*)
        agent="${arg#--agent=}"
        ;;
    esac
  done

  if [[ -n "$agent" ]]; then
    agent="$(printf '%s' "$agent" | tr '[:upper:]' '[:lower:]')"
    if [[ "$agent" != "manual" ]]; then
      return 0
    fi
  fi

  local pause_timeout="${SMART_WRAPPER_PAUSE_TIMEOUT:-10}"
  if [[ "$pause_timeout" =~ ^[0-9]+$ ]] && [[ "$pause_timeout" -gt 0 ]]; then
    if ! read -r -t "$pause_timeout" -p "Press Enter to continue... (auto-continue in ${pause_timeout}s) "; then
      echo ""
    fi
  else
    read -r -p "Press Enter to continue..."
  fi
}
