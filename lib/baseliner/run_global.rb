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

      CHECKS.each do |check|
        puts center(cyan(check.name))

        threads = projects.map { |project| Thread.new { check.call(project:) } }

        threads.zip(projects).each do |thread, project|
          Baseliner::Spin.call(thread)
          puts spread(project.name, thread.value)
        end
      end
    end
  end
end
