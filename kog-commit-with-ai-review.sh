#!/usr/bin/env bash
#
# kog-commit-with-ai-review.sh - Commit wrapper with default ai-review enabled

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
    if [[ "$arg" == "$long_name" || "$arg" == "$short_name" ]]; then
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

exec bash "$ROOT/kog" commit "${ARGS[@]}"
