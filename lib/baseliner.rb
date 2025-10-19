# frozen_string_literal: true

require "capybara"
require "fileutils"
require "io/console"
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

    def add_project
      config[:paths] = registered_paths.push(Dir.pwd).uniq.sort
      save_config
    end
  end
end

require_relative "baseliner/helpers"
require_relative "baseliner/integrations"

require_relative "baseliner/checks"
require_relative "baseliner/run"
require_relative "baseliner/run_global"
