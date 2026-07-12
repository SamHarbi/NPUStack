# AMD NPU Local LLM Deployment
This repo defines 'diary' styled instructions in addition to all software artifacts used to deploy a working NPU based system on my personal laptop for simple coding tasks- Fully self-hosted on machine.

## Starting Line: Specs and Env
This repo is focused on a Linux based environment as this is what I use on my dev machine. Specific details:
Distro: Debian (trixie) with Linux Kernal 7.0.4. Installed via backports. Otherwise we don't have the ```amdxdna``` driver which was introduced in the kernal starting v7.

Otherwise, this project deploys everything as a container. I use podman, docker works just as well.

## User
Create a new server user to run containers. This is to isolate any host variables and behaviours, currently that is soft and hard ulimits.
```
sudo adduser server
sudo usermod -a -G render,video server
```

## Latest NPU firmware on Debian (2026/06)
### 1. Ensure the target directory exists
sudo mkdir -p /lib/firmware/amdnpu/17f0_10

### 2. Download the required modern NPU firmware directly from upstream git
sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/amdnpu/17f0_10/npu.sbin.1.1.2.64 -O /lib/firmware/amdnpu/17f0_10/npu_7.sbin

### 3. Create a fallback symlink just in case your package variations check for it
sudo ln -sf npu_7.sbin /lib/firmware/amdnpu/17f0_10/npu.sbin

## Build & Deploy Instructions
1. Run `Make` in ./src/builder
2. Run START.sh

## Misc

Run `Make` in ./src/builder or
```
podman build -t fastflowlm .
podman compose up (Starts docker server)
podman tag fastflowlm:latest localhost:5000/fastflowlm:latest
podman push --tls-verify=false localhost:5000/fastflowlm:latest
```

(Optional) Run Container directly, without compose
```
sudo -E /home/sam/.nix-profile/bin/podman run -it --device /dev/kfd --device /dev/dri --device=/dev/accel/accel0 --group-add keep-groups --tls-verify=false --ulimit memlock=-1:-1 localhost:5000/fastflowlm
```

Run START.sh or
```
sudo -E /nix/var/nix/profiles/default/bin/nix develop
```