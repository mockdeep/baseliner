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
        puts Baseliner::Checks::SimpleCov.call(path: Dir.pwd)
      else
        abort("Unknown command: #{args.first.inspect}")
      end
    end
  end
end
