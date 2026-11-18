#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/scripts/sync-testbed.sh"
cd "$(dirname "$0")"
PORT="${CMP_TESTBED_PORT:-8777}"
echo "CMP plugin testbed: http://127.0.0.1:${PORT}/login.html"
exec python3 -m http.server "$PORT"