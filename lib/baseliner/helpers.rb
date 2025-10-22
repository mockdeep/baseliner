# frozen_string_literal: true

module Baseliner::Helpers
  # run command and raise error on failure
  def run_or_raise(command, path:)
    stdout, stderr, status = Open3.capture3(command, { chdir: path })

    unless status.success?
      puts(stdout) if ENV["DEBUG"]
      puts(stderr) if ENV["DEBUG"]

      raise "failed to run '#{command}'"
    end

    stdout.strip
  end

  def run_command(command, path:)
    stdout, _stderr, _status = Open3.capture3(command, { chdir: path })
    stdout.strip
  end
end
