---
id: TASK-8
title: Map a live sandbox allowlist (secrets stay out of repo)
status: To Do
assignee: []
created_date: '2026-09-22 00:12'
labels:
  - harness
milestone: m-1
dependencies:
  - TASK-5
references:
  - reference/allowlist.md
  - reference/detectability.md
priority: high
type: task
ordinal: 8000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Until a harness owns resolver, trust store, and raw-IP egress, the YAML is a fixture. Next work after smoke is mapping what that sandbox may resolve and connect to. Live lists, CA names, and tenant ids must not land in this public repo.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A private lab doc or issue (not this repo) lists intercepted names, sinkholed DoH/DoT, and blocked origin IPs for one sandbox
- [ ] #2 reference/allowlist.md remains a category template only
- [ ] #3 DoH/DoT and real origin IPs are blocked in that harness
<!-- AC:END -->
