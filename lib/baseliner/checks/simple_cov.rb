# frozen_string_literal: true

module Baseliner::Checks::SimpleCov
  class << self
    def call
      FileUtils.remove_entry_secure("./coverage/")
      run_id = `gh run list -b main --json databaseId -L 1 -q .[].databaseId`
      messages = `gh run download #{run_id.strip} -n coverage -D coverage`
      contents = File.read("coverage/index.html")
      document = Capybara.string(contents)
      "Ruby Coverage: #{lines_covered(document)} lines covered, " \
        "#{branches_covered(document)} branches covered"
    rescue StandardError
      puts messages if ENV["DEBUG"]
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
