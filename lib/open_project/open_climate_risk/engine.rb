# frozen_string_literal: true

require "open_project/plugins"
require "open_project/open_climate_risk/patches/work_package_patch"

module OpenProject
  module OpenClimateRisk
    class Engine < ::Rails::Engine
      engine_name :openproject_open_climate_risk

      include OpenProject::Plugins::ActsAsOpEngine

      register "openproject-open_climate_risk",
               author_url: "https://climateandtech.org",
               requires_openproject: ">= 13.0" do
        # Integration gem: four-eye, glue webhook provisioning (v2+ iframe tab backlog).
      end

      patches [:WorkPackage]

      assets %w[open_climate_risk/logo-wordmark.png open_climate_risk/logo.png open_climate_risk/logo-header.png]

      config.to_prepare do
        BrandI18n.apply!
      end

      config.after_initialize do
        next unless Configuration.auto_ensure_glue_webhook?

        result = WebhookEnsurer.ensure!
        next if result[:success] || result[:skipped]

        Rails.logger.error "[open_climate_risk] glue webhook ensure failed: #{result[:errors]}"
      end
    end
  end
end
