# frozen_string_literal: true

module OpenProject
  module OpenClimateRisk
    module Configuration
      module_function

      def four_eye_vulnerability?
        !%w[0 false no off].include?(ENV.fetch("OPEN_CLIMATE_RISK_FOUR_EYE_VULNERABILITY", "1").downcase)
      end

      def auto_ensure_glue_webhook?
        raw = ENV.fetch("OPEN_CLIMATE_RISK_ENSURE_GLUE_WEBHOOK", "").downcase
        return false if %w[0 false no off].include?(raw)
        return true if glue_webhook_url.present? && raw.empty?

        %w[1 true yes on].include?(raw)
      end

      def glue_webhook_url
        ENV["OPEN_CLIMATE_RISK_GLUE_WEBHOOK_URL"].to_s.strip
      end

      def glue_webhook_secret
        ENV["OPEN_CLIMATE_RISK_GLUE_WEBHOOK_SECRET"].to_s
      end

      def project_identifier
        ENV.fetch("OPEN_CLIMATE_RISK_PROJECT_IDENTIFIER", "open-climate-risk")
      end

      def platform_title
        ENV.fetch("OPEN_CLIMATE_RISK_PLATFORM_TITLE", "Climate Management Platform")
      end

      def module_title
        ENV.fetch("OPEN_CLIMATE_RISK_MODULE_TITLE", "Open Climate Risk")
      end

      def glue_public_url
        ENV["OPEN_CLIMATE_RISK_GLUE_PUBLIC_URL"].to_s.strip
      end

      def glue_workbench_url
        return "" if glue_public_url.blank?

        "#{glue_public_url.delete_suffix('/')}/start"
      end
    end
  end
end
