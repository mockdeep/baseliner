# frozen_string_literal: true

module Baseliner::Init
  class << self
    def call
      config_path = File.join(Dir.pwd, "baseliner.yml")
      if File.exist?(config_path)
        abort("baseliner.yml already exists in this directory.")
      end

      project_name = request_project_name

      checks =
        Baseliner::Checks::ALL.each_with_object({}) do |check, result|
          result[check.name.to_sym] = { enabled: true }
        end
      config = { project_name:, checks: }

      File.write(config_path, config.to_yaml(stringify_names: true))
      puts "Created baseliner.yml for project '#{project_name}'."
    end

    def request_project_name
      project_name = File.basename(Dir.pwd).capitalize
      print("Project name? (default: #{project_name}) ")
      input = $stdin.gets.chomp
      input.presence || project_name
    end
  end
end
