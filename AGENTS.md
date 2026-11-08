# AGENTS.md

Instructions for AI coding agents (and other LLM tools that read this file) working on this repository. This follows the widely supported `AGENTS.md` convention recognised by OpenCode, Codex, Cursor, and other agent tools.

## Project identity

- Canonical project name: **NPUStackedCoder**
- Repository slug is still `npu-llm` — do **not** rename the repository or change any repository settings without explicit owner instruction.
- Rename user-facing text consistently to NPUStackedCoder. Do not reintroduce the old names StackedNPU or NPU-Flux.

## Mandatory AI-agent attribution

Every GitHub issue and pull request created by an AI agent **must** include the following line in the **body** (never in the title):

```text
[Done by: Crouton Alpha | OpenCode]
```

- Include it in issue bodies, pull request bodies, and issue/PR comments made by the agent.
- Do not put it in titles.
- If an existing issue/PR body cannot be edited, add it in a comment on that issue/PR.

## Scope notes from the owner (issue #2)

- Requirements claims in the README are assumed verified by the owner. Do not rewrite README claims without owner direction — keep the README as notes with guidelines and ready formatting for the owner to verify personally.
- Windows 11 support is out of scope for the Linux release. Do not claim Windows support; Windows/WSL2 is tracked separately in #23.
- Model tags referenced in the repo (e.g. `qwen3.6-moe:35b-a3b`, `qwen3.5:9b`) are real FastFlowLM tags; link to the upstream FastFlowLM model specs rather than inventing specs.
- Do not claim a Docker Hub image exists until the owner publishes one. Placeholder TODO sections are preferred over fictional commands.

## Working rules

- One ticket per branch/PR where practical; reference the issue in the PR body (e.g. `Closes #2`).
- Before creating a PR, check for a PR template (`.github/pull_request_template.md` or `.github/PULL_REQUEST_TEMPLATE/`). If none exists, say so in the PR body.
- Keep changes minimal and consistent with the ticket's acceptance criteria. Do not bundle unrelated cleanups into the same PR.
- Never commit secrets, tokens, API keys, or `dummy-key` credentials. Configuration belongs in `.env` files, with `.env.example` committed instead.
- Linux first: the supported deployment target is Linux with podman or docker preinstalled. Nix is an optional dev convenience, not a requirement.
- Verify links and commands you add. If you cannot verify something, mark it `TODO (owner to verify)` instead of stating it as fact.
