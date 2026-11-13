# Pinned base image (PUB-011). Ubuntu 26.04 index digest as published on
# Docker Hub (resolute-20261024.1); re-resolve before upgrading:
#   docker buildx imagetools inspect ubuntu:26.04
ARG BASE_IMAGE=ubuntu:26.04@sha256:6a06111c3b0a8600feadb270aec771dc239bf407b25625f93f44ab00e11f4d3c
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.description="FastFlowLM runtime environment (built from source)"

# Prevent interactive prompts during installation
ARG UBUNTU_PPA=""
ARG BACKPORTS=""

# Optional PPA escape hatch (e.g. --build-arg UBUNTU_PPA=ppa:amd-team/xrt).
# The third-party PPAs previously added unconditionally
# FastFlowLM builds against the distro libxrt-dev package.
# Set up PPA if needed
RUN if [ -n "$UBUNTU_PPA" ]; then \
        apt update && apt install -y software-properties-common && \
        add-apt-repository -y "$UBUNTU_PPA"; \
    fi

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cargo \
    cmake \
    debhelper-compat \
    dpkg-dev \
    fakeroot \
    git \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libboost-dev \
    libboost-program-options-dev \
    libcurl4-openssl-dev \
    libdrm-dev \
    libfftw3-dev \
    libreadline-dev \
    libswresample-dev \
    libswscale-dev \
    libxrt-dev \
    nasm \
    ninja-build \
    patchelf \
    pkg-config \
    rustc \
    uuid-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Build context is fastflowlm/ (see compose.yaml / builder/Makefile).
# The FastFlowLM source is the pinned git submodule at external/fastflowlm;
# its CMake source directory is external/fastflowlm/src.
COPY ./external/fastflowlm ./upstream/fastflowlm
COPY ./fastflowlm-build.sh ./fastflowlm-build.sh

RUN chmod +x ./fastflowlm-build.sh && ./fastflowlm-build.sh

CMD ["/bin/bash"]
