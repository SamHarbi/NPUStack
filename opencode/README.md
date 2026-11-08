# OpenCode Agent-Dev Container

`Dockerfile` in this directory builds the OpenCode agent-development
image used by the `opencode` service in the root `compose.yaml`. It is
the second source-built image in this repo, alongside the FastFlowLM
container in `../fastflowlm/`.

## Approach

Option 1: the image is based **on** the pinned upstream OpenCode image
(`ghcr.io/anomalyco/opencode`) and layers agent tooling on top,
instead of reinstalling OpenCode on a clean base.

- Base: `ghcr.io/anomalyco/opencode:2.2.6` pinned by tag + digest
  (see the `OPENCODE_IMAGE` build arg in the Dockerfile). Re-resolve
  the digest from the GHCR package page before upgrading.
- The upstream image is **Alpine-based** (`apk`/musl) and already
  bundles `bun` and `ripgrep`; the Dockerfile verifies `bun --version`
  instead of reinstalling it.

## Tools

Installed via `apk` (all agent-beneficial):

`git`, `gh` (github-cli), `ssh` (openssh-client), `curl`, `jq`,
`ripgrep`, `fd`, `make`, `python3` + `uv` (pip venv — `uv` is not in
Alpine stable repos), `nodejs` + `npm` + `pnpm`, `neovim`.

Intentionally not installed:

- `aider`, `llm` CLI — not needed in this container
- `starship`, `tmux`, `fzf`, `bat`, `eza` — human-UX tools
- `ca-certificates` — provided by the base OS
- `podman`, `docker` — no container engine inside the agent container
- `rust`, `cargo`

## Building and running

```bash
podman build -t npustackedcoder-opencode-dev ./opencode
# or: docker build -t npustackedcoder-opencode-dev ./opencode

podman compose up -d opencode
```

The root `compose.yaml` builds this image for the `opencode` service
and mounts `./workspace` at `/workspace`, plus the persisted
`data/opencode-config` and `data/opencode-share` volumes.

## Configuration

`opencode.json.example` is a template pointing OpenCode at the local
FastFlowLM OpenAI-compatible endpoint (`http://fastflowlm:52625/v1`).
Copy it into your config volume and adjust the model name. Verify it
against the OpenCode v2 config schema before relying on it — API keys
come from the environment (`.env`), never from the repo (PUB-012).

This container needs **no NPU devices**: it talks HTTP-only to the
FastFlowLM service, so `/dev/accel*` stays in the FastFlowLM container.

## Notes / TODO

- Runs as root to stay compatible with the existing `/root/.config/opencode`
  and `/root/.local/share/opencode` volumes. A non-root `dev` user
  (with migrated volumes) is a follow-up.
- `uv` is currently unpinned (pip venv install); pin a version.
- A clean build + a trivial agent task against local FastFlowLM have
  not yet been run in this environment (PUB-020).
