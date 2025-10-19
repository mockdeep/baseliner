# frozen_string_literal: true

module Baseliner::Helpers
  # run command and raise error on failure
  def run_or_raise(command)
    stdout, stderr, status = Open3.capture3(command)

    unless status.success?
      puts(stderr) if ENV["DEBUG"]

      raise "failed to run '#{command}'"
    end

    stdout.strip
  end
end
