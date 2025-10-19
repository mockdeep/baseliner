# frozen_string_literal: true

module Baseliner::Checks::SimpleCov
  class << self
    include Baseliner::Integrations

    def call
      FileUtils.remove_entry_secure("./coverage/")
      run_id = Github.latest_build_id
      Github.download_artifact(run_id, "coverage")

      contents = File.read("coverage/index.html")
      document = Capybara.string(contents)
      "Ruby Coverage: #{lines_covered(document)} lines covered, " \
        "#{branches_covered(document)} branches covered"
    rescue StandardError
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
