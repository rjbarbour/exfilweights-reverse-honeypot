---
id: TASK-5
title: Prove smoke.sh on a Docker host
status: To Do
assignee: []
created_date: '2026-09-22 00:12'
updated_date: '2026-09-22 00:17'
labels:
  - tripwire
milestone: m-0
dependencies:
  - TASK-2
references:
  - smoke.sh
  - reference/viability.md
priority: high
type: task
ordinal: 5000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
This sandbox has no Docker daemon. The binary extracted from m4r10/beelzebub:v3.9.1 answered the three GETs and logged /exfil/v1/, but compose itself has not been observed to boot. Do not add extra lures until that is true. YAML is already sufficient for detection.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 On a host with Docker Compose v2, ./smoke.sh from the repo root exits 0
- [ ] #2 Printed lines include Handler names and /exfil/v1/
- [ ] #3 Host cannot reach the listener except on 127.0.0.1:8080
- [ ] #4 reference/SMOKE_RESULT.txt or reference/NOTES.md records the host run
<!-- AC:END -->
