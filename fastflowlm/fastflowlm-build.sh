#!/bin/sh
set -eu
cd /workspace/deployment/external/fastflowlm/src
cmake --preset linux-default
cmake --build build -j"$(nproc)"
cd build && cmake --install .
