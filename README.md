# Skills Workspace

This repository contains local Codex skills and packaged `.skill` artifacts.

## Layout

Each skill should follow this structure:

```text
<skill-name>/
├── SKILL.md
├── agents/openai.yaml
├── references/      (optional)
├── scripts/         (optional)
└── assets/          (optional)
```

## Commands

Run from repository root:

```bash
./scripts/validate-skills.sh
./scripts/build-skills.sh
```

`build-skills.sh` runs validation first, then rebuilds all files in `dist/*.skill`.
