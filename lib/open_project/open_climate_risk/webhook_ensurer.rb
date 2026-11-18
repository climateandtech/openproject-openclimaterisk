# frozen_string_literal: true

module OpenProject
  module OpenClimateRisk
    # Outgoing OP webhooks are not in API v3 — register glue via plugin or rake.
    class WebhookEnsurer
      WEBHOOK_NAME = "Open Climate Risk glue"
      EVENTS = %w[work_package:updated work_package:created].freeze

      def self.ensure!
        return skip("webhooks module not loaded") unless defined?(::Webhooks::Webhook)

        url = Configuration.glue_webhook_url
        return skip("OPEN_CLIMATE_RISK_GLUE_WEBHOOK_URL unset") if url.empty?

        webhook = ::Webhooks::Webhook.find_by("LOWER(name) = ?", WEBHOOK_NAME.downcase)
        webhook ||= ::Webhooks::Webhook.new_default

        project = Project.find_by(identifier: Configuration.project_identifier)
        attrs = {
          name: WEBHOOK_NAME,
          url: url,
          description: "Provisioned by openproject-open_climate_risk — physrisk side effects on glue",
          secret: Configuration.glue_webhook_secret.presence,
          enabled: true,
          events: EVENTS
        }

        if project
          attrs[:project_ids] = "selected"
          attrs[:selected_project_ids] = [project.id]
        else
          attrs[:project_ids] = "all"
          Rails.logger.warn "[open_climate_risk] project #{Configuration.project_identifier.inspect} not found; webhook scoped to all projects"
        end

        actor = User.admin.active.first
        actor ||= User.system if User.respond_to?(:system)

        service = ::Webhooks::Outgoing::UpdateWebhookService.new(webhook, current_user: actor)
        result = service.call(attributes: attrs)

        unless result.success?
          return { success: false, errors: result.errors.full_messages }
        end

        { success: true, webhook_id: result.result.id, url: url }
      end

      def self.skip(reason)
        { success: false, skipped: true, reason: reason }
      end
      private_class_method :skip
    end
  end
end
