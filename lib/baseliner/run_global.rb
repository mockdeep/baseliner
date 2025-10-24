# frozen_string_literal: true

module Baseliner::RunGlobal
  class << self
    include Baseliner::Colors

    CHECKS = [
      Baseliner::Checks::SimpleCov,
      Baseliner::Checks::BundleOutdated,
      Baseliner::Checks::RubocopTodos,
    ].freeze

    def call
      projects = Baseliner.projects

      if projects.empty?
        abort("No registered projects found. Please add a project first.")
      end

      threads =
        CHECKS.flat_map do |check|
          [
            Thread.new { center(cyan(check.name)) },
            *projects.map do |project|
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
