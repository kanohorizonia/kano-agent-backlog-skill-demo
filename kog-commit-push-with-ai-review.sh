#!/usr/bin/env bash
#
# kog-commit-push-with-ai-review.sh - Commit+push wrapper with default ai-review enabled

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

has_arg() {
  local needle="$1"
  shift || true
  local arg
  for arg in "$@"; do
    if [[ "$arg" == "$needle" ]]; then
      return 0
    fi
  done
  return 1
}

has_option_with_value() {
  local long_name="$1"
  local short_name="$2"
  shift 2 || true
  local args=("$@")
  local i arg
  for ((i = 0; i < ${#args[@]}; i++)); do
    arg="${args[$i]}"
    if [[ "$arg" == "$long_name" || ( -n "$short_name" && "$arg" == "$short_name" ) ]]; then
      if ((i + 1 < ${#args[@]})); then
        return 0
      fi
    fi
    if [[ "$arg" == "$long_name="* ]]; then
      return 0
    fi
  done
  return 1
}

ARGS=()
for arg in "$@"; do
  if [[ "$arg" == "--ai-review" || "$arg" == "--no-ai-review" ]]; then
    continue
  fi
  ARGS+=("$arg")
done

if ! has_option_with_value "--provider" "-p" "${ARGS[@]}"; then
  ARGS+=("--provider" "${KOG_COMMIT_PROVIDER:-copilot}")
fi

if ! has_option_with_value "--model" "" "${ARGS[@]}"; then
  ARGS+=("--model" "${KOG_COMMIT_MODEL:-gpt-5-mini}")
fi

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

set +e
bash "$ROOT/kog" commit --push "${ARGS[@]}"
status=$?
set -e
pause_if_needed
exit "$status"
