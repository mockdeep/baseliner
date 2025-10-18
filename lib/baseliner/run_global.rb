# frozen_string_literal: true

module Baseliner::RunGlobal
  class << self
    def call
      paths = Baseliner.registered_paths

      if paths.empty?
        abort("No registered projects found. Please add a project first.")
      end

      paths.each do |path|
        Dir.chdir(path) { puts Baseliner::Checks::SimpleCov.call }
      end
    end
  end
end
