# frozen_string_literal: true

require "active_support/all"
require "capybara"
require "fileutils"
require "open3"
require "yaml"

require_relative "baseliner/version"

module Baseliner
  class << self
    CONFIG_PATH = File.join(Dir.home, ".config/baseliner.yml")

    def config
      @config ||=
        if File.exist?(CONFIG_PATH)
          YAML.load_file(CONFIG_PATH, symbolize_names: true)
        else
          {}
        end
    end

    def save_config
      File.write(CONFIG_PATH, config.to_yaml(stringify_names: true))
    end

    def registered_paths
      config[:paths] ||= []
    end

    def projects
      @projects ||=
        registered_paths.map { |path| Baseliner::Models::Project.new(path:) }
    end
  end
end

require_relative "baseliner/colors"
require_relative "baseliner/helpers"
require_relative "baseliner/integrations"
require_relative "baseliner/spin"

require_relative "baseliner/checks"
require_relative "baseliner/init"
require_relative "baseliner/models"
require_relative "baseliner/register"
require_relative "baseliner/run"
require_relative "baseliner/run_global"
