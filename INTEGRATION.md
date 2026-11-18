# Open Climate Risk — OpenProject integration plugin

One **hybrid gem** for everything OP cannot do via API v3 alone:

| Capability | Status | Env / task |
| --- | --- | --- |
| **Four-eye** on In review → closed | v0.2 | `OPEN_CLIMATE_RISK_FOUR_EYE_VULNERABILITY` (default on) |
| **Outgoing webhook** → glue | v0.2 | `OPEN_CLIMATE_RISK_GLUE_WEBHOOK_URL`, optional secret; rake or auto |
| **Embed glue UI** (WP tab / iframe) | backlog | `OPEN_CLIMATE_RISK_GLUE_EMBED_BASE_URL` |
| **PoC work packages** | — | `glue/seed_poc.py` after `openproject/seed_vocabulary.py` |
| Project template / custom fields | backlog | Prefer API seed or future seeder |

Glue still owns physrisk, DuckDB, and Kind A APIs. This plugin is the **OP-side integrator**.

## Glue webhook (no REST API, no admin UI)

**Plugin:** set `OPEN_CLIMATE_RISK_GLUE_WEBHOOK_URL` (+ secret) and restart OP — auto `WebhookEnsurer` (same as admin). Opt out: `OPEN_CLIMATE_RISK_ENSURE_GLUE_WEBHOOK=0`.

**No gem:** `openproject/seed_outgoing_webhook.py` with `OPENPROJECT_DATABASE_URL` — upserts `webhooks_*` tables.

Optional: `rake open_climate_risk:ensure_glue_webhook` or admin UI.

Events: `work_package:updated`, `work_package:created`. Scoped to `open-climate-risk` when the project exists.

## Compose sketch (custom OP image)

```yaml
environment:
  OPEN_CLIMATE_RISK_GLUE_WEBHOOK_URL: https://glue-host/webhooks/openproject
  OPEN_CLIMATE_RISK_GLUE_WEBHOOK_SECRET: ${OPENPROJECT_WEBHOOK_SECRET}
  OPEN_CLIMATE_RISK_ENSURE_GLUE_WEBHOOK: "1"
  OPEN_CLIMATE_RISK_FOUR_EYE_VULNERABILITY: "1"
```

Requires `Gemfile.plugins` entry for this gem (see README).
