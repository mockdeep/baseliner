# frozen_string_literal: true

module Baseliner::RunGlobal
  class << self
    include Baseliner::Colors

    def call
      projects = Baseliner.projects

      if projects.empty?
        abort("No registered projects found. Please add a project first.")
      end

      threads =
        Baseliner::Checks::ALL.flat_map do |check|
          relevant_projects =
            projects.select { |project| project.check_enabled?(check) }

          next [] if relevant_projects.none?

          [
            Thread.new { center(cyan(check.name)) },
            *relevant_projects.map do |project|
              Thread.new { spread(project.name, check.call(project:)) }
            end,
          ]
        end

      threads.each do |thread|
        Baseliner::Spin.call(thread)
        puts thread.value
      end
    end
  end
end
