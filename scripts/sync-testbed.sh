#!/usr/bin/env bash
# Refresh testbed CSS/JS from plugin sources (run before ./testbed/serve.sh).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BRAND="$(cd "$ROOT/../brand" && pwd)"
TB="$ROOT/testbed"

mkdir -p "$TB/assets/open_climate_risk"
cp "$ROOT/frontend/module/global_styles.scss" "$TB/plugin.css"
for sed_expr in \
  's|/assets/open_climate_risk/|assets/open_climate_risk/|g' \
  's|^//(.*)$|/*\1 */|'; do
  sed -i '' -E "$sed_expr" "$TB/plugin.css" 2>/dev/null || sed -i -E "$sed_expr" "$TB/plugin.css"
done

cp "$ROOT/frontend/module/global_scripts.ts" "$TB/plugin.js"
for sed_expr in \
  's/\): void/)/g' \
  's/: string//g' \
  's/querySelector<[^>]+>/querySelector/g' \
  's/: HTMLElement//g; s/: HTMLAnchorElement//g; s/ as HTMLElement//g; s/ as HTMLAnchorElement//g' \
  's/\(window as unknown as \{ I18n\?: \{ t\?: \(key: string\) => string \} \}\)\.I18n/window.I18n/g' \
  's/\(window as unknown as \{ I18n\?: \{ t\?: \(key\) => string \} \}\)\.I18n/window.I18n/g'; do
  sed -i '' -E "$sed_expr" "$TB/plugin.js" 2>/dev/null || sed -i -E "$sed_expr" "$TB/plugin.js"
done

cp "$BRAND/logo-wordmark.png" "$TB/assets/open_climate_risk/logo-wordmark.png"
for f in openproject-logo.png openproject-logo-white.png; do
  [ -f "$BRAND/$f" ] && cp "$BRAND/$f" "$TB/assets/$f"
done
echo "testbed synced -> $TB"