#!/usr/bin/env sh
set -euo pipefail

echo "[PRE-STOP] Flushing data at $(date -Iseconds)"
# Ejemplo: rotar el log y dejar una marca de flush
if [ -f /data/events.log ]; then
  cp /data/events.log "/data/events-$(date +%s).log.bak"
fi
echo "flushed=$(date -Iseconds)" > /data/flush.info
