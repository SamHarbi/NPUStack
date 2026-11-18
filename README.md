<p align="center">
  <img src="./images/logo.svg" alt="NPUStack logo" width="40%">
  <br>
  <em>Containerized, AMD NPU optimised inference stack</em>
</p>



<p align="center">
  <img src="./images/showcase-opencode.png" width="100%" alt="NPUStack + OpenCode writing python fully locally">
  <br>
  <em>Qwen3.5:9b working via OpenCode enabled Agentic/Vibe Coding on NPUStack</em>
</p>

# About

NPUStack is a containerized deployment of FastFlowLM and other accompanying AI tools optimized for pure NPU inference on AMD hardware when battery power is a priority, while still allowing for seamless switchover to cloud services. Based on my own laptop/portable agentic stack, this project is opinionated towards the following goals:

- **High power efficiency and background friendly:** All local inference runs entirely on an NPU, without ever touching a CPU nor GPU, Keeps the system responsive with a minimal effect on power draw (subject to RAM constraints).
- **Linux first, secure containerized deployment:** I daily drive Linux for my dev work. This project is a _mostly_ one click containerized deploy that is stable and secure in separating agents from host.
- **Bleeding-edge, Frontier local AI:** NPUStack tracks and builds the main branch of FastFlowLM, I can quickly deploy the latest models as soon as they're supported on AMD hardware.

### Containers (The Stack in NPUStack)
   
<p align="center">
  <img src="./images/npustack_architecture.svg" alt="Container architecture" width="85%">
</p>

- **FastFlowLM**: Configured NPU runtime backend server.
- **OpenCode Web Interface**: NPU, Bring your own API or use a hosted model provided by the OG developers. 
- **Squid**: Forward and reverse proxy gating internal NPUStack network and host / the internet. Extra layer of control to keep Agents in check, especially once planned browser tools get added in a future version
- **Steel Browser (Planned)**: All Agent browser activity goes through Steel for first-class agent support and security

> [!WARNING]
> Although this project explicitly aims to create a secure agentic environment. This capability has not been meaningfully tested on the open internet and cannot provide any assurances or fit for purpose of any kind (See License).


## System Requirements

### Hardware
- AMD Processor with integrated AMD XDNA 2 NPU (e.g., Ryzen AI 300/400 series).
- Sufficient RAM and storage for model weights.

### Software & OS
- **OS**: Linux only for now. MacOS is unsupported (See NPU requirement). Windows / WSL2 is out of scope for this release — see #23. I mainly test this project on Debian.
- **Kernel**: If on Linux: Version 7.0+ required to include the `amdxdna` driver. Older kernels may require backports or manual driver installation.
- **Container Runtime**: Podman, or alternatively Docker should work. I use and test on the former though.

## Quick Start Guide

### Container Image (Docker Hub)

> [!NOTE]
> TODO (owner to verify): No public container image is published yet. This section is a placeholder for the Docker Hub release state.
> - Image name: TBD
> - Tags: TBD
> - Published: No
>
> Once published, the intended one-liner will be documented here, e.g.:
> ```bash
> docker run -d -p 8080:80 --name NPUStack_Instance <image>
> ```


## Building from source (Linux)
### 1. Firmware Installation
Ensure the AMD NPU firmware is present on your system. If using a standard Debian installation, you may need to install it manually or via package manager:
```bash
# Attempt automatic installation first
sudo apt update && sudo apt install linux-firmware-amd-npu

# If that fails or requires specific versions, download manually:
# Note: Direct links from kernel.org archives are often blocked. 
# Use a mirror if available, or extract from the official firmware repo.
sudo mkdir -p /lib/firmware/amdnpu/17f0_10
sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/amdnpu/17f0_10/npu.sbin.1.1.2.64 -O /lib/firmware/amdnpu/17f0_10/npu_7.sbin
sudo ln -sf npu_7.sbin /lib/firmware/amdnpu/17f0_10/npu.sbin
```

### 2. Building the overall stack
TODO

## Local NPU Performance

> [!NOTE]
> TODO (owner to verify / fill in): No benchmarks for this stack are published yet. Fill in the table below with reproducible results, and link the upstream reference for comparison.

Upstream reference:

- [FastFlowLM benchmarks](https://github.com/ROCm/FastFlowLM/blob/main/docs/benchmarks.md)

Guidelines for entries:

- Record hardware (CPU / NPU model), kernel, NPU firmware, and FastFlowLM version/commit.
- Record model + quantization, context length, and prompt / workload.
- Report decode (tokens/s) and prefill (tokens/s) separately where available.

| Model | Hardware / NPU | Context | Decode (tok/s) | Prefill (tok/s) | Notes |
|---|---|---|---|---|---|
| TBD | TBD | TBD | TBD | TBD | TBD |

## Configuration
See the ``` config/ ``` directory for config that is fed directly into their respective containers.

### Supported Models
For local FastFlowLM models running on the NPU, all models are supported as per upstream docs at: 
- [FastFlowLM model specs / catalog](https://github.com/ROCm/FastFlowLM/blob/main/docs/models.md)

### Environment Variables in Containers
The `fastflowlm` container exposes specific environment variables to control behavior:
- `MODEL_1`: Specifies the model identifier (e.g., `qwen3.6-moe:35b-a3b`). This is used by the startup script to pull and validate models before serving.

### Volume Mounts & Device Mapping
To ensure NPU/GPU access, specific devices are mounted into the container:
- `/dev/kfd`: Kernel Fusion Driver (GPU).
- `/dev/dri`: Direct Rendering Interface (GPU).
- `/dev/accel/accel0`: AMD XDNA Accelerator.

Models are stored in `../models` and mapped to `/root/.config/flm` inside the container.

## Troubleshooting & Tips
- **Ulimits**: The `fastflowlm` container configures unlimited memory locks (`memlock: -1:-1`). If you encounter permission issues with cgroups, ensure the host allows these settings.
- **Model Loading**: This can take quite a while depending on the model. OpenCode may timeout your first request, but downloads continue in the background and restart if interrupted.
