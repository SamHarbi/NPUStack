ARG BASE_IMAGE=ubuntu:26.04
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.description="FastFlowLM runtime environment (built from source)"

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ARG UBUNTU_PPA=""
ARG BACKPORTS=""

# Set up PPA if needed
RUN if [ -n "$UBUNTU_PPA" ]; then \
        apt update && apt install -y software-properties-common && \
        add-apt-repository -y "$UBUNTU_PPA"; \
    fi

# setup backports if needed
RUN if [ -n "$BACKPORTS" ]; then \
        echo "deb http://deb.debian.org/debian $BACKPORTS main" >> /etc/apt/sources.list; \
        apt update; \
        apt install -t $BACKPORTS -y libxrt-dev; \
    fi

# Install all build dependencies
# Cannot install amdxdna-dkms here, that's a host kernel job
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository -y ppa:lemonade-team/stable \
    && add-apt-repository -y ppa:amd-team/xrt \
    && apt-get update && apt-get install -y --no-install-recommends \
    libxrt-npu2 \
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
    curl \
    zstd \
    libedit-dev \
    libxrt-dev \
    libdrm-dev \
    && rm -rf /var/lib/apt/lists/*

# The distro's rustc is too old for the tokenizers crate, so CI used to
# install stable with rustup in every job. Baked in here instead, ahead of the
# distro toolchain on PATH (whose cargo/rustc packages stay: the .deb's
# Build-Depends name them). World-writable so a job running as any user can
# update the registry.
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        sh -s -- -y --profile minimal --default-toolchain stable --no-modify-path \
    && chmod -R a+w "$RUSTUP_HOME" "$CARGO_HOME" \
    && rustc --version

WORKDIR /workspace

# Build context is fastflowlm/ (see compose.yaml / builder/Makefile).
# The FastFlowLM source is the pinned git submodule at external/fastflowlm;
# its CMake source directory is external/fastflowlm/src.
COPY ./external/fastflowlm ./upstream/fastflowlm
COPY ./fastflowlm-build.sh ./fastflowlm-build.sh

RUN chmod +x ./fastflowlm-build.sh && ./fastflowlm-build.sh

ENV PATH="/opt/fastflowlm/bin/:${PATH}"

CMD ["/bin/bash"]
