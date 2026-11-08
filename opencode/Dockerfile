# Pinned upstream OpenCode layer (PUB-025, option 1: FROM the upstream image).
# ghcr.io/anomalyco/opencode:2.2.6, digest as published on the GHCR package
# page (https://github.com/anomalyco/opencode/pkgs/container/opencode).
# Re-resolve before upgrading.
ARG OPENCODE_IMAGE=ghcr.io/anomalyco/opencode:2.2.6@sha256:520b2d66e7bebad4548de65c8033ed44277dfe4163471c80fe729fe17f748d97
FROM ${OPENCODE_IMAGE}

LABEL org.opencontainers.image.description="NPUStackedCoder OpenCode agent-development environment"

# The upstream image is Alpine-based (apk/musl). It already bundles bun
# and ripgrep; we verify bun below instead of reinstalling it.
# ca-certificates is intentionally NOT installed: the base OS provides it.
RUN apk add --no-cache \
        git \
        github-cli \
        openssh-client \
        curl \
        jq \
        ripgrep \
        fd \
        make \
        python3 \
        py3-pip \
        nodejs \
        npm \
        pnpm \
        neovim \
    # uv is not in Alpine stable repos; install it into a venv so the
    # system Python stays untouched. TODO: pin the uv version here.
    && python3 -m venv /opt/uv \
    && /opt/uv/bin/pip install --no-cache-dir uv \
    && ln -s /opt/uv/bin/uv /usr/local/bin/uv \
    # Verify the tools agents rely on, including bun from the base layer.
    && opencode --version \
    && bun --version \
    && rg --version \
    && git --version \
    && gh --version \
    && jq --version \
    && fd --version \
    && python3 --version \
    && uv --version \
    && node --version \
    && pnpm --version \
    && nvim --version

# Deliberately NOT installed (see README): aider, llm CLI, starship,
# tmux, fzf, bat, eza, podman, docker, rust, cargo, ca-certificates.

WORKDIR /workspace

# Default command matches the compose service; compose can override it.
CMD ["opencode", "serve", "--hostname", "0.0.0.0", "--port", "8081"]
