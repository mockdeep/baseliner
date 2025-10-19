# frozen_string_literal: true

module Baseliner::RunGlobal
  class << self
    CHECKS = [Baseliner::Checks::SimpleCov].freeze

    def call
      paths = Baseliner.registered_paths

      if paths.empty?
        abort("No registered projects found. Please add a project first.")
      end

      _, columns = IO.console.winsize
      CHECKS.each do |check|
        puts " #{check.name} ".center(columns, "=")

        threads = paths.map { |path| Thread.new { check.call(path:) } }

        threads.each { |thread| puts thread.value }
      end
    end
  end
end
