# frozen_string_literal: true

require "capybara"
require "fileutils"
require "open3"
require "yaml"

require_relative "baseliner/version"

module Baseliner
  class << self
    CONFIG_PATH = File.join(Dir.home, ".config/baseliner.yml")

    def config
      @config ||= File.exist?(CONFIG_PATH) ? YAML.load_file(CONFIG_PATH) : {}
    end

    def save_config
      File.write(CONFIG_PATH, config.to_yaml)
    end

    def registered_paths
      config[:paths] ||= []
    end

    def projects
      @projects ||=
        registered_paths.map do |path|
          project_config_path = File.join(path, "baseliner.yml")
          project_config = YAML.load_file(project_config_path)
          project_name = project_config.fetch(:project_name)
          Baseliner::Models::Project.new(name: project_name, path:)
        end
    end
  end
end

require_relative "baseliner/colors"
require_relative "baseliner/helpers"
require_relative "baseliner/integrations"

require_relative "baseliner/checks"
require_relative "baseliner/init"
require_relative "baseliner/models"
require_relative "baseliner/register"
require_relative "baseliner/run"
require_relative "baseliner/run_global"
