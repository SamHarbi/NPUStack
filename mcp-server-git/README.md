# mcp-server-git Agent-Dev Container

`Dockerfile` in this directory builds mcp-server-git into a custom http endpoint container.
This approach is taken to avoid exposing git in the opencode / agent container and fully rely on external, isolated mcp servers. This has the advantage of avoiding showing agents any github credentials. Works in tandem with the Github MCP server, which gives access to GitHub.

Note: This has not been implemented in the Stack yet. TODO for a future release.