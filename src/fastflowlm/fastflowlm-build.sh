#!/bin/sh
cd ./src/external/fastflowlm/src
cmake -B build -S . -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded -DFLM_VERSION=1.0.0 -DNPU_VERSION=0.6.0
cmake --build build --config Release
cd build && cmake --install .