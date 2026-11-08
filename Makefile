.PHONY: help up down logs

help:
	@echo "NPUStack (npu-llm) - local helpers"
	@echo "  make up    - start the stack with podman compose"
	@echo "  make down  - stop the stack"
	@echo "  make logs  - follow stack logs"

up:
	podman compose -f src/docker-compose.yml up -d

down:
	podman compose -f src/docker-compose.yml down

logs:
	podman compose -f src/docker-compose.yml logs -f
