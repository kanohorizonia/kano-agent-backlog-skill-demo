# Welcome to Kano Agent Backlog Skill Demo

This repository demonstrates the capabilities of the **Kano Agent Backlog Skill** - a local-first, file-based backlog management system for AI agent collaboration.

## Releases

- Latest: `docs/releases/0.0.2.md`
- Previous: `docs/releases/0.0.1.md`

## Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/dorgonman/kano-agent-backlog-skill-demo.git
cd kano-agent-backlog-skill-demo
```

### 2. Initialize submodules
```bash
git submodule update --init --recursive
```

### 3. Build the native CLI
```bash
bash src/cpp/build/script/windows/build_windows_ninja_msvc_debug.sh
```

### 4. Verify installation
```bash
./kob doctor
```

### 5. Kob foundation helpers
```bash
bash script/bootstrap --help
bash script/setup
bash script/test
bash scripts/core/doctor.sh
bash scripts/core/status.sh
bash scripts/core/list-topics.sh
bash scripts/core/list-worksets.sh
bash scripts/core/list-workitems.sh --product kano-agent-backlog-skill
bash scripts/core/read-workitem.sh KABSD-TSK-0001 --product kano-agent-backlog-skill
bash scripts/core/check-config.sh
bash scripts/core/create-workitem.sh --help
bash scripts/core/set-ready-fields.sh --help
bash scripts/core/create-topic.sh --help
bash scripts/core/switch-topic.sh --help
bash scripts/internal/show-version.sh
bash scripts/internal/bump-version.sh patch --dry-run
bash scripts/internal/create-tag.sh --from-version-file --dry-run
bash scripts/tags/list-tags.sh --latest
bash scripts/internal/self-build.sh debug
```

### 6. Explore the demo backlog
```bash
# List work items
./kob workitem list --product kano-agent-backlog-skill
```

## Official Documentation

For comprehensive documentation, including detailed guides and API references, please visit our [Official Documentation Website](https://dorgonman.github.io/kano-agent-backlog-skill).
