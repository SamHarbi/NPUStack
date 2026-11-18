# FastFlowLM Container

Dockerfile and build script in this directory build the FastFlowLM
server container from source (the `external/fastflowlm` submodule).
This is the container that runs the FastFlowLM server.

See the top-level README for the overall stack.

## Building

Clone with submodules (required — the build compiles FastFlowLM from
the pinned submodule source):

```bash
git clone --recurse-submodules <this-repo>
cd <this-repo>
podman build -t fastflowlm ./fastflowlm
# or: docker build -t fastflowlm ./fastflowlm
```

If you cloned without submodules, initialise them first:

```bash
git submodule update --init --recursive
```

Ensure githooks are activated to apply patches if applicable

## Pinned FastFlowLM source

- Submodule: `fastflowlm/external/fastflowlm`
  (upstream: https://github.com/ROCm/FastFlowLM)
- Pinned commit at the time of writing:
  `11ffea14fc1cbe0121a2576d5426ceddf20753b6`
  (check the current pin with `git submodule status`)

To upgrade the pin:

```bash
cd fastflowlm/external/fastflowlm
git fetch
git checkout <tag-or-commit>
cd ../../..
git add fastflowlm/external/fastflowlm
```

## Base image

`Dockerfile` pins `ubuntu:26.04` by digest via the `BASE_IMAGE`
build arg. To upgrade, re-resolve the digest and update the arg:

```bash
docker buildx imagetools inspect ubuntu:26.04
```

The third-party PPAs (`lemonade-team/stable`, `amd-team/xrt`) are not
added by default; pass `--build-arg UBUNTU_PPA=ppa:amd-team/xrt` if
your NPU runtime needs them. The `amdxdna-dkms` kernel driver is
intentionally not installed in the container — it belongs on the host
kernel (see top-level README, PUB-005).
