# AMD NPU Local LLM Deployment
This repo defines 'diary' styled instructions in addition to all software artifacts used to deploy a working NPU based system on my personal laptop for simple coding tasks- Fully self-hosted on machine.

## Starting Line: Specs and Env
This repo is focused on a Linux based environment as this is what I use on my dev machine. Specific details:
Distro: Debian (trixie) with Linux Kernal 7.0.4. Installed via backports. Otherwise we don't have the ```amdxdna``` driver which was introduced in the kernal starting v7.

Otherwise, this project deploys everything as a container. I use podman, docker works just as well.
