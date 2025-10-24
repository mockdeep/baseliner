# frozen_string_literal: true

module Baseliner::Checks::SimpleCov
  class << self
    include Baseliner::Colors
    include Baseliner::Helpers

    Github = Baseliner::Integrations::Github

    def name
      "SimpleCov"
    end

    # Determines if the check is applicable to the given path
    def applicable?(path:)
      ruby_project?(path:)
    end

    def call(project:)
      path = project.path
      FileUtils.rm_rf(File.join(path, "coverage"))
      run_id = Github.latest_build_id(path:)
      unless Github.download_artifact(path:, run_id:, name: "coverage")
        return red("No coverage data found.")
      end

      contents = File.read(File.join(path, "coverage/index.html"))
      document = Capybara.string(contents)
      "Lines: #{color_percent(lines_covered(document))}, " \
        "Branches: #{color_percent(branches_covered(document))}"
    end

    private

    def lines_covered(document)
      document
        .find("#AllFiles > .t-line-summary")
        .all("span", count: 3)
        .last.text.strip
    end

    def branches_covered(document)
      document
        .find("#AllFiles > .t-branch-summary")
        .all("span", count: 4)
        .last.text.strip
    end
  end
end
