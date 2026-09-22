---
id: doc-2
title: Grok Build vs Backlog.md
type: other
created_date: '2026-09-22 00:11'
updated_date: '2026-09-22 00:11'
---
# Grok Build vs Backlog.md

Grok Build has **no first-party markdown project board**.

What it does have:

- Conversation-scoped **subagents** for parallel implementation
- A **scheduler** for recurring prompts
- **GitHub Issues / PRs** via the GitHub connector

Those are not a durable, repo-native backlog. Backlog.md (MrLesk, `backlog.md` on npm) is adopted here as the project board: tasks, decisions, and docs as Markdown in `backlog/`, CLI as the source of truth.

Do not run `backlog browser` on a public interface. Default bind is loopback (`127.0.0.1:6420`). Do not add inbound SSH/Telnet honeypots.

Agents: run `backlog instructions overview` at the start of a conversation in this repo. Create and edit tasks only through the CLI.
