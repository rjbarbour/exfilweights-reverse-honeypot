---
id: TASK-9
title: Eval-path bland error for recorded traces
status: To Do
assignee: []
created_date: '2026-09-22 00:12'
labels:
  - tripwire
milestone: m-0
dependencies:
  - TASK-5
references:
  - reference/viability.md
priority: low
type: feature
ordinal: 9000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Default in this repo is canary 200 + success true so a live lab box is easy to watch. Recorded evals used for training or scoring must not reward the escape policy with that success JSON.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 A documented eval/fixture mode returns a bland error or clearly marked fixture instead of success true
- [ ] #2 Lab/canary mode remains the compose default
- [ ] #3 README or viability.md states which mode is which
<!-- AC:END -->
