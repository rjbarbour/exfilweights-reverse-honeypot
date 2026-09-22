---
id: TASK-4
title: 'Operator README, allowlist template, no tenant secrets'
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
  - README.md
  - reference/allowlist.md
  - reference/viability.md
priority: medium
type: docs
ordinal: 4000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
A public repo is right for the pattern and compose file, wrong for sandbox allowlists, proxy CA names, and tenant ids. Operators still need a checklist of categories.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Root README describes tripwire, smoke, steer methods, and loopback-only
- [x] #2 reference/allowlist.md lists names to intercept and DoH/DoT to sinkhole without live IPs or CA names
- [x] #3 Viability public-repo rule is not violated
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Root README is the operator front page. allowlist.md is a category template only.
<!-- SECTION:FINAL_SUMMARY:END -->
