---
id: TASK-1
title: Fix Beelzebub compose boot
status: Done
assignee:
  - grok-build
created_date: '2026-09-22 00:11'
updated_date: '2026-09-22 00:17'
labels:
  - tripwire
milestone: m-0
dependencies: []
references:
  - docker-compose.yml
  - reference/NOTES.md
priority: high
type: chore
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The reference compose used a non-existent Docker Hub image (beelzebub-labs/beelzebub), camelCase flags, and an all-interfaces bind. The decoy could not start and would have been reachable from the public internet if it had.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Compose uses m4r10/beelzebub:v3.9.1
- [x] #2 Flags are --conf-core and --conf-services; command is flags only because ENTRYPOINT already runs
- [x] #3 Listener published only as 127.0.0.1:8080
- [x] #4 Compose network is internal: true (no default route)
- [x] #5 YAML in services/ validates
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Working compose/YAML/smoke moved from reference/ to repo root. reference/ is notes and handoff only.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Image, kebab-case flags, loopback bind, internal network, and landing YAML indent are in reference/. Validated by extracting the v3.9.1 binary; this sandbox has no Docker daemon.
<!-- SECTION:FINAL_SUMMARY:END -->
