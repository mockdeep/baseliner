# frozen_string_literal: true

# Check for outdated gems in a Ruby project using Bundler
module Baseliner::Checks::BundleOutdated
  class << self
    include Baseliner::Colors
    include Baseliner::Helpers

    # Returns the name of the check
    def name
      "Bundle Outdated"
    end

    # Determines if the check is applicable to the given path
    def applicable?(path:)
      ruby_project?(path:)
    end

    # Performs the check on the given project
    def call(project:)
      path = project.path
      run_or_raise("bundle install", path:)
      major = run_command("bundle outdated --filter-major --parseable", path:)
      minor = run_command("bundle outdated --filter-minor --parseable", path:)

      major_count = major.lines.count(&:present?)
      minor_count = minor.lines.count(&:present?)

      "Major: #{color_number(major_count)}, Minor: #{color_number(minor_count)}"
    end
  end
end
