.PHONY: help up down logs

help:
	@echo "NPUStack (npu-llm) - local helpers"
	@echo "  make up    - start the stack with podman compose"
	@echo "  make down  - stop the stack"
	@echo "  make logs  - follow stack logs"

up:
	podman compose -f compose.yaml up -d

down:
	podman compose -f compose.yaml down

logs:
	podman compose -f compose.yaml logs -f
