FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

RUN uv pip install --system --no-cache mcp-server-git

WORKDIR /workspace

ENV HOST=0.0.0.0 \
    PORT=8082

EXPOSE 8082

ENTRYPOINT ["mcp-server-git", "--transport", "streamable-http", "--repository", "/workspace"]
