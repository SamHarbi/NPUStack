# Builder

This is a makefile driven construct to build the fastflowlm container and host it on a localhost registry, useful for transferring built containers among users on your machine (Personal user -> Server user with server config, etc..)

The registry service also exists in the root `compose.yaml` under the
`registry` profile (`podman compose --profile registry up -d`). This
standalone compose file is kept for builder-only use.
