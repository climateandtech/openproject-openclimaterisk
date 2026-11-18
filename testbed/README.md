# CMP plugin local testbed

**Real OpenProject + plugin (login works):** from repo root run `./scripts/dev-openproject-cmp.sh` → http://127.0.0.1:9080/login (`admin` / `ocr_local_admin` in `.env.local`). Requires Docker.

This folder is **static HTML only** — branding preview without OpenProject.

```bash
cd open-climate-risk/openproject-plugin
./testbed/serve.sh
# open http://127.0.0.1:8777/login.html
```

After editing `frontend/module/global_styles.scss` or `global_scripts.ts`:

```bash
./scripts/sync-testbed.sh
```

Then hard-refresh the browser.

**What it loads**

| File | Source |
|------|--------|
| `plugin.css` | `frontend/module/global_styles.scss` (asset paths rewritten) |
| `plugin.js` | `frontend/module/global_scripts.ts` (stripped for browser) |
| `assets/open_climate_risk/logo-wordmark.png` | `open-climate-risk/brand/logo-wordmark.png` |
| `assets/openproject-logo.png` | OP high-contrast logo (for `with OpenProject`) |

`op-base.css` simulates default OP layout (wide-label login, blue button) so you can see plugin overrides.