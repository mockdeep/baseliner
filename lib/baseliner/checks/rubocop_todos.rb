# frozen_string_literal: true

# check for counting rubocop todos and offenses
module Baseliner::Checks::RubocopTodos
  class << self
    include Baseliner::Colors
    include Baseliner::Helpers

    # Returns the name of the check
    def name
      "Rubocop Todos"
    end

    # Determines if the check is applicable to the given path
    def applicable?(path:)
      ruby_project?(path:)
    end

    # Performs the check on the given project
    def call(project:)
      todos_path = File.join(project.path, ".rubocop_todo.yml")
      return red("No .rubocop_todo.yml found.") unless File.exist?(todos_path)

      todos = File.read(todos_path)
      offense_counts = todos.scan(/Offense count: (\d+)/)
      total_offenses = offense_counts.flatten.sum { |num| Integer(num) }
      "Cops: #{color_number(offense_counts.size)}, " \
        "Offenses #{color_number(total_offenses)}"
    end
  end
end
