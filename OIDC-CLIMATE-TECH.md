# Path C (later): Climate+Tech → OpenProject UI (GPL, no EE)

OpenProject Community does not include Enterprise OIDC *client* configuration.
If product needs users to **sign into the OP UI** with Climate+Tech SSO:

1. Ship a new gem under **GPL-3.0-or-later** (same as [openproject-open_climate_risk.gemspec](openproject-open_climate_risk.gemspec)).
2. Suggested name: `openproject-climate_tech_oidc`.
3. Register an OmniAuth OIDC strategy against Climate+Tech `OIDC_ISSUER` (discovery, client id/secret, callback on the OP host).
4. Map email/login claims to OP users; document admin enable via `Gemfile.plugins`.
5. Do **not** buy OpenProject Enterprise; do **not** use a proprietary plugin license.

This slice is deferred. Product default remains Path B: Climate+Tech SSO at platform/glue edge; OP via `OPENPROJECT_API_TOKEN`. See [docs/AUTH.md](../docs/AUTH.md).
