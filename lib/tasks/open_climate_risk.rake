# frozen_string_literal: true

namespace :open_climate_risk do
  desc "Create or update outgoing webhook to Open Climate Risk glue (OPEN_CLIMATE_RISK_GLUE_WEBHOOK_URL)"
  task ensure_glue_webhook: :environment do
    result = OpenProject::OpenClimateRisk::WebhookEnsurer.ensure!
    puts result.inspect
    abort "webhook ensure failed" if result[:success] == false && !result[:skipped]
  end
end
