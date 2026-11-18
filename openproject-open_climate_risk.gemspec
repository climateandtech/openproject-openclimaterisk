# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "open_project/open_climate_risk/version"

Gem::Specification.new do |s|
  s.name        = "openproject-open_climate_risk"
  s.version     = OpenProject::OpenClimateRisk::VERSION
  s.authors     = ["Climate+Tech"]
  s.email       = ["hello@climateandtech.com"]
  s.homepage    = "https://climateandtech.org/open-climate-risk"
  s.summary     = "Climate Management Platform branding, four-eye, and glue for OpenProject Community"
  s.description = <<-DESC.strip
    Marketing-ready OpenProject plugin for ESRS physical climate risk workflows.
    Blocks the same user from closing a work package that they moved to In review.
  DESC
  s.license     = "GPL-3.0-or-later"
  s.metadata    = {
    "source_code_uri" => "https://github.com/climateandtech/openproject-openclimaterisk",
    "bug_tracker_uri" => "https://github.com/climateandtech/openproject-openclimaterisk/issues"
  }

  s.files = Dir[
    "{lib,config,doc,frontend,app}/**/*",
    "LICENSE",
    "package.json",
    "*.md",
    "lib/tasks/**/*.rake"
  ]
  s.require_paths = ["lib"]
end
