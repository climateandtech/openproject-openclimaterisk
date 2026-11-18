# frozen_string_literal: true

module OpenProject
  module OpenClimateRisk
    module BrandI18n
      module_function

      def platform_title
        ENV.fetch("OPEN_CLIMATE_RISK_PLATFORM_TITLE", "Climate Management Platform")
      end

      def module_title
        ENV.fetch("OPEN_CLIMATE_RISK_MODULE_TITLE", "Open Climate Risk")
      end

      def apply!
        I18n.backend.store_translations(
          :en,
          {
            homescreen: {
              additional: {
                blocks: {
                  community: "#{platform_title} — #{module_title}"
                }
              }
            },
            label_product: platform_title
          }
        )

        js = {
          js: {
            open_climate_risk: {
              platform_title: platform_title,
              module_title: module_title,
              homescreen_tagline: "Physical climate risk and ESRS workflows on %{platform}.",
              glue_workbench_url: Configuration.glue_workbench_url
            }
          }
        }
        I18n.backend.store_translations(:en, js)
      end
    end
  end
end