#!/bin/sh
set -eu

if ! command -v nix >/dev/null 2>&1; then
    echo "error: nix not found on PATH" >&2
    echo "Install Nix, or use podman/docker directly (see README.md)." >&2
    exit 1
fi

# Run from this script's directory, not the caller's cwd.
cd "$(dirname "$0")/src"
exec nix develop
