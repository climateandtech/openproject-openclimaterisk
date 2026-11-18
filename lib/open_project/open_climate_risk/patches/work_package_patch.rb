# frozen_string_literal: true

module OpenProject
  module OpenClimateRisk
    module Patches
      module WorkPackagePatch
        extend ActiveSupport::Concern

        included do
          validate :open_climate_risk_four_eye, if: :status_id_changed?
        end

        private

        def open_climate_risk_four_eye
          return unless OpenProject::OpenClimateRisk::Configuration.four_eye_vulnerability?

          previous_status = Status.find_by(id: status_id_was)
          new_status = status
          return if previous_status.nil? || new_status.nil?
          return unless new_status.is_closed?

          current_id = User.current&.id
          submitter_id = in_review_submitter_from_journals(previous_status.id)

          return unless FourEyeGuard.violation?(
            previous_status_name: previous_status.name,
            new_status_closed: true,
            current_user_id: current_id,
            in_review_submitter_id: submitter_id
          )

          errors.add(
            :status,
            I18n.t(
              "open_project.open_climate_risk.errors.four_eye_same_reviewer",
              platform_title: OpenProject::OpenClimateRisk::Configuration.platform_title,
              module_title: OpenProject::OpenClimateRisk::Configuration.module_title
            )
          )
        end

        # User who last moved this work package into +in_review_status_id+ before the current change.
        def in_review_submitter_from_journals(in_review_status_id)
          journals
            .joins(:details)
            .where(journal_details: { prop_key: "status_id", value: in_review_status_id.to_s })
            .order(id: :desc)
            .pick(:user_id)
        end
      end
    end
  end
end
