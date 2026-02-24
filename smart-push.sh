#!/usr/bin/env bash
#
# smart-push.sh - Project-level wrapper for multi-repository push
#
# This script points to the kano-git-master-skill push tool.
# It can be run from any directory within the project.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT/smart-wrapper-common.sh"

SKILL_SCRIPT="$(resolve_skill_script_path "$ROOT" "scripts/commit-tools/smart-push.sh")"
ensure_skill_script_exists "$SKILL_SCRIPT"

set +e
run_skill_script_from_root "$ROOT" "$SKILL_SCRIPT" "$@"
status=$?
set -e
pause_if_needed "$@"
exit "$status"
