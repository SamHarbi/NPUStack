.PHONY: start
start:
	sudo mkdir -p /home/server/npu-llm && \
	sudo cp -r ./* /home/server/npu-llm/ && \
	sudo chown server /home/server/npu-llm/ && \
	sudo mkdir -p /home/server/.config/containers/ && \
	sudo mv /home/server/npu-llm/src/fastflowlm/policy.json /home/server/.config/containers/
# 	nix develop
# 	su server
# 	podman compose run