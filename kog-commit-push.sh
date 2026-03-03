#!/usr/bin/env bash
#
# kog-commit-push.sh - Commit+push wrapper with default no-ai-review

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

ARGS=("$@")
if ! has_arg "--ai-review" "${ARGS[@]}" && ! has_arg "--no-ai-review" "${ARGS[@]}"; then
  ARGS+=("--no-ai-review")
fi

exec bash "$ROOT/kog" commit --push "${ARGS[@]}"
