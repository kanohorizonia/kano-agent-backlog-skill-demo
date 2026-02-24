#!/usr/bin/env bash
#
# smart-status.sh - Project-level wrapper for repository status
#
# This script points to the kano-git-master-skill status tool.
# It can be run from any directory within the project.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT/smart-wrapper-common.sh"

SKILL_SCRIPT="$(resolve_skill_script_path "$ROOT" "scripts/workspace/status-all-repos.sh")"
ensure_skill_script_exists "$SKILL_SCRIPT"

# Run the actual script
set +e
run_skill_script_from_root "$ROOT" "$SKILL_SCRIPT" "$@"
status=$?
set -e
pause_if_needed "$@"
exit "$status"
