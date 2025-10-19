# frozen_string_literal: true

module Baseliner::Checks::SimpleCov
  class << self
    Github = Baseliner::Integrations::Github

    def call(path:)
      FileUtils.rm_rf(File.join(path, "coverage"))
      run_id = Github.latest_build_id(path:)
      Github.download_artifact(path:, run_id:, name: "coverage")

      contents = File.read(File.join(path, "coverage/index.html"))
      document = Capybara.string(contents)
      "Ruby Coverage: #{lines_covered(document)} lines covered, " \
        "#{branches_covered(document)} branches covered"
    rescue StandardError => e
      puts e.message if ENV["DEBUG"]
      "No coverage data found."
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
