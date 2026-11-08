FROM ubuntu:26.04

LABEL org.opencontainers.image.description="FastFlowLM runtime environment"

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ARG UBUNTU_PPA=""
ARG BACKPORTS=""

# Set up PPA if needed
RUN if [ -n "$UBUNTU_PPA" ]; then \
        apt update && apt install -y software-properties-common && \
        add-apt-repository -y "$UBUNTU_PPA"; \
    fi

RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository -y ppa:lemonade-team/stable \
    && add-apt-repository -y ppa:amd-team/xrt \
    && apt-get update && apt-get install -y --no-install-recommends \
    libxrt-npu2 \
    amdxdna-dkms \
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

COPY ./* ./deployment/

RUN ls ./deployment/fastflowlm/

RUN chmod +x ./deployment/fastflowlm-build.sh && ./deployment/fastflowlm-build.sh

CMD ["/bin/bash"]
