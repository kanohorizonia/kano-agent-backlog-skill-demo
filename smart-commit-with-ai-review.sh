#!/usr/bin/env bash
#
# smart-commit-with-ai-review.sh - Project-level wrapper for commits with AI review enabled
#
# This script points to the kano-git-master-skill commit tool.
# It can be run from any directory within the project.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT/smart-wrapper-common.sh"

SKILL_SCRIPT="$(resolve_skill_script_path "$ROOT" "scripts/commit-tools/commit/smart-commit-copilot.sh")"
ensure_skill_script_exists "$SKILL_SCRIPT"

ARGS=("$@")
if ! has_arg "--ai-review" "${ARGS[@]}" && ! has_arg "--no-ai-review" "${ARGS[@]}"; then
  ARGS+=("--ai-review")
fi

set +e
run_skill_script_from_root "$ROOT" "$SKILL_SCRIPT" "${ARGS[@]}"
status=$?
set -e
pause_if_needed "$@"
exit "$status"
