---
id: TASK-6
title: Hash-and-discard write payloads (YAML cannot)
status: To Do
assignee: []
created_date: '2026-09-22 00:12'
labels:
  - plugin
milestone: m-2
dependencies:
  - TASK-5
references:
  - reference/NOTES.md
  - reference/viability.md
priority: high
type: feature
ordinal: 6000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Viability requires path metadata plus a hash, never the base64 chunk. Config-only Beelzebub logs event.RequestURI in full, and for /write that URI is the chunk. Smoke redacts on print; the log file still holds the payload. A plugin or log pipeline is required. Do not fork gitlab.com/tlb/exfil.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Logged write events keep bucket, filename, offset, and a hash of the last path segment
- [ ] #2 Logged write events do not contain the raw base64 chunk
- [ ] #3 Create and run-model still 200 with static success JSON
- [ ] #4 No GGUF bytes persisted; no llama.cpp
<!-- AC:END -->
