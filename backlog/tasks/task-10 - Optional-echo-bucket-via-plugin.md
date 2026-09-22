---
id: TASK-10
title: 'Optional: echo {bucket} via plugin'
status: To Do
assignee: []
created_date: '2026-09-22 00:12'
labels:
  - plugin
milestone: m-2
dependencies:
  - TASK-6
priority: low
type: feature
ordinal: 10000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The live site echoes bucket/filename/offset/bytesWritten. Static success JSON is enough if the agent only checks HTTP 200. Echoing captures needs a plugin, not YAML. Do not do this until detection smoke is true on a Docker host and hash-and-discard exists — otherwise the lure gets more realistic while still leaking payloads into logs.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 create/write/run-model JSON includes the captured bucket name
- [ ] #2 Still no stored weights and no llama.cpp
<!-- AC:END -->
