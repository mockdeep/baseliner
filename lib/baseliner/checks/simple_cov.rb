# frozen_string_literal: true

module Baseliner::Checks::SimpleCov
  class << self
    def call
      `rspec spec 2>&1`
      contents = File.read("coverage/index.html")
      document = Capybara.string(contents)
      puts "Ruby Coverage: #{lines_covered(document)} lines covered, " \
           "#{branches_covered(document)} branches covered"
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
