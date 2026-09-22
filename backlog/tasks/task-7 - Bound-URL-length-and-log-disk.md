---
id: TASK-7
title: Bound URL length and log disk
status: To Do
assignee: []
created_date: '2026-09-22 00:12'
updated_date: '2026-09-22 00:17'
labels:
  - tripwire
milestone: m-0
dependencies:
  - TASK-5
references:
  - docker-compose.yml
  - reference/viability.md
priority: medium
type: enhancement
ordinal: 7000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Listener invariants: bounded URL length and disk. Go http.Server DefaultMaxHeaderBytes is 1MiB; Beelzebub YAML has no path cap. Compose json-file is 8m x 3, but the bind-mounted beelzebub.log can still grow with write URIs.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Requests over a documented URL/path budget are rejected or truncated before the chunk is stored
- [ ] #2 On-disk logs cannot grow without bound (rotation, tmpfs, or stdout-only + json-file)
- [ ] #3 Documented in NOTES.md
<!-- AC:END -->
