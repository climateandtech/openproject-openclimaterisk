# Changelog

## 0.4.2

- Co-brand header: canonical `brand/logo.png` as OCR mark, × separator, stock OpenProject logo (no replacement).
- Shadcn surfaces unchanged.

## 0.4.1

- Shadcn-style surfaces (zinc cards, radius, borders, focus rings) on Primer; keep OpenProject naming and logos.
- Glue workbench header link when `OPEN_CLIMATE_RISK_GLUE_PUBLIC_URL` is set.

## 0.4.0

- Glue webhook wiring in compose/boot/deploy; initial login chrome experiments (superseded by 0.4.1).

## 0.3.0 — 2026-11-14

- Community branding: `global_styles.scss`, logo asset, `BrandI18n`, `js-en.yml`
- Platform title **Climate Management Platform**; module **Open Climate Risk** via env

## 0.2.0 — 2026-11-13

- Integration scope: `WebhookEnsurer` + `rake open_climate_risk:ensure_glue_webhook`
- Env-driven four-eye toggle; auto webhook on boot optional
- `INTEGRATION.md`

## 0.1.0 — 2026-11-13

- Four-eye validation on work package close from **In review**
- Marketing README and GPLv3 packaging
