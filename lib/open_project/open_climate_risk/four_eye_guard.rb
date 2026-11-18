# frozen_string_literal: true

module OpenProject
  module OpenClimateRisk
    # Pure logic for four-eye: reviewer must differ from whoever sent the WP to In review.
    module FourEyeGuard
      IN_REVIEW_STATUS_NAMES = [
        "in review",
        "in_review"
      ].freeze

      module_function

      def in_review_status?(status_name)
        normalized = status_name.to_s.downcase.strip
        IN_REVIEW_STATUS_NAMES.include?(normalized)
      end

      def violation?(previous_status_name:, new_status_closed:, current_user_id:, in_review_submitter_id:)
        return false unless new_status_closed
        return false unless in_review_status?(previous_status_name)
        return false if in_review_submitter_id.nil? || current_user_id.nil?

        in_review_submitter_id.to_i == current_user_id.to_i
      end
    end
  end
end
