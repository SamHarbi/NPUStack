export BASE_IMAGE := debian:latest

all:
	podman build --build-arg BASE_IMAGE=$$BASE_IMAGE -t fastflowlm:1.0.0 ./fastflowlm/

