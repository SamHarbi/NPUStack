# AGENTS.md

## Mandatory AI-agent attribution

Every GitHub issue and pull request created by an AI agent **must** include the following line in the **body** (never in the title):

```text
[Done by: 'LLM/Agent Model name' | 'Harness or tool used']
```

- Include it in issue bodies, pull request bodies, and issue/PR comments made by the agent.
- Do not put it in titles.
- If an existing issue/PR body cannot be edited, add it in a comment on that issue/PR.

## Working rules

- One ticket per branch/PR where practical; reference the issue in the PR body (e.g. `Closes #2`).
- Before creating a PR, check for a PR template (`.github/pull_request_template.md` or `.github/PULL_REQUEST_TEMPLATE/`). If none exists, say so in the PR body.
- Keep changes minimal and consistent with the ticket's acceptance criteria. Do not bundle unrelated cleanups into the same PR if possible. Otherwise, document any unrelated fixes. Prefer to open new pull requests.
- Never commit secrets, tokens, API keys, or `dummy-key` credentials. Configuration belongs in `.env` files, with `.env.example` committed instead.
- Verify links and commands you add. If you cannot verify something, mark it `TODO (owner to verify)` instead of stating it as fact.
