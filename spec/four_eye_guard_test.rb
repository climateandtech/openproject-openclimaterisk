#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "open_project/open_climate_risk/four_eye_guard"

failures = 0

def assert!(cond, msg)
  return if cond

  warn "FAIL: #{msg}"
  @failures = (@failures || 0) + 1
end

@failures = 0

g = OpenProject::OpenClimateRisk::FourEyeGuard

assert! g.in_review_status?("In review"), "recognises In review"
assert! !g.violation?(
  previous_status_name: "Open",
  new_status_closed: true,
  current_user_id: 1,
  in_review_submitter_id: 1
), "ignores non-review prior status"

assert! g.violation?(
  previous_status_name: "In review",
  new_status_closed: true,
  current_user_id: 42,
  in_review_submitter_id: 42
), "blocks same user closing from In review"

assert! !g.violation?(
  previous_status_name: "In review",
  new_status_closed: true,
  current_user_id: 42,
  in_review_submitter_id: 7
), "allows different reviewer"

if @failures.positive?
  warn "#{@failures} failure(s)"
  exit 1
end

puts "four_eye_guard_test: ok"
