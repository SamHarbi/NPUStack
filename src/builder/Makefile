.PHONY: build
build:
	podman build -t fastflowlm ../fastflowlm/.
	podman tag fastflowlm:latest localhost:5000/fastflowlm:latest
	podman push --tls-verify=false localhost:5000/fastflowlm:latest