#!/bin/sh
set -eu

# FastFlowLM's CMake source directory inside the pinned submodule.
SRC_DIR="${SRC_DIR:-/workspace/upstream/fastflowlm/src}"

if [ ! -d "$SRC_DIR" ]; then
    echo "error: FastFlowLM source not found at $SRC_DIR" >&2
    echo "Clone with submodules: git clone --recurse-submodules <repo>" >&2
    exit 1
fi

cd "$SRC_DIR"
cmake --preset linux-default
cmake --build build -j"$(nproc)"
cd build && cmake --install .
