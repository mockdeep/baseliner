# frozen_string_literal: true

module Baseliner::Init
  class << self
    def call
      config_path = File.join(Dir.pwd, "baseliner.yml")
      if File.exist?(config_path)
        abort("baseliner.yml already exists in this directory.")
      end

      project_name = File.basename(Dir.pwd).capitalize
      print("Project name? (default: #{project_name}) ")
      input = $stdin.gets.chomp
      project_name = input unless input.empty?

      config_content = { project_name: }

      File.write(config_path, config_content.to_yaml)
      puts "Created baseliner.yml for project '#{project_name}'."
    end
  end
end
