# Open Climate Risk — OpenProject plugin

OpenProject Community plugin for the **Climate Management Platform**: branding, four-eye close rules, and glue webhook provisioning for ESRS physical climate risk workflows.

| Item | Detail |
| --- | --- |
| **OpenProject** | Community **13+** (`ActsAsOpEngine`) |
| **License** | [GNU GPL v3.0 or later](LICENSE) (required for Community plugins) |
| **Package** | Ruby gem `openproject-open_climate_risk` |
| **Copyright** | © 2026 [Climate+Tech](https://climateandtech.org) |

## License (GPL-3.0-or-later)

OpenProject Community is GPLv3. This plugin is distributed under the **GNU General Public License, version 3 or any later version**. You may redistribute and/or modify it under those terms.

- Full license text: [LICENSE](LICENSE) (includes GPLv3 full text)
- Short notice: [doc/GPL.txt](doc/GPL.txt)

If you distribute a combined work (OpenProject + this plugin), GPL obligations apply to the plugin and to how you offer corresponding source. Do **not** ship this gem under a proprietary license on the Community edition path. OpenProject Enterprise features are separate commercial offerings from OpenProject GmbH.

## Install

Add to OpenProject `Gemfile.plugins` (see [Gemfile.plugins.example](Gemfile.plugins.example)), run `bundle install`, precompile frontend assets, restart.

Docker/CMP image build: [climateandtech/openclimaterisk](https://github.com/climateandtech/openclimaterisk) (`openproject/docker-cmp/`).

## Configuration

See [INTEGRATION.md](INTEGRATION.md) for four-eye, glue webhooks, and branding env vars (`OPEN_CLIMATE_RISK_*`).

## Development

```bash
bundle install
# Static login chrome preview:
./scripts/sync-testbed.sh && ./testbed/serve.sh
```

## Changelog

[CHANGELOG.md](CHANGELOG.md)