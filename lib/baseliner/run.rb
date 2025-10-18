# frozen_string_literal: true

module Baseliner::Run
  class << self
    def call(args)
      case args.first
      when "add_project"
        Baseliner.add_project
      when "run_global"
        Baseliner::RunGlobal.call
      when "run"
        Baseliner::Checks::SimpleCov.call
      else
        abort("Unknown command: #{args.first.inspect}")
      end
    end
  end
end
