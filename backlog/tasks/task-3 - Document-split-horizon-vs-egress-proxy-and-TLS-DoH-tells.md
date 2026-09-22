---
id: TASK-3
title: Document split-horizon vs egress-proxy and TLS/DoH tells
status: Done
assignee:
  - grok-build
created_date: '2026-09-22 00:11'
updated_date: '2026-09-22 00:12'
labels:
  - tripwire
  - docs
milestone: m-0
dependencies: []
references:
  - reference/detectability.md
priority: high
type: docs
ordinal: 3000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Steering the sandbox onto the decoy is the actual defence. Two methods (lab DNS vs proxy rewrite) have different residual tells. Without that written down, a lab will publish HTTP on loopback and assume the agent arrives.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 detectability.md explains split-horizon DNS and what DoH/DoT bypasses
- [x] #2 detectability.md explains egress-proxy Host rewrite plus TLS intercept
- [x] #3 Residual tells listed: issuer, fingerprint, CT, pinning, DoH
- [x] #4 README points operators at that file
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Both steer methods and TLS/DoH detectability are in reference/detectability.md. README links them.
<!-- SECTION:FINAL_SUMMARY:END -->
