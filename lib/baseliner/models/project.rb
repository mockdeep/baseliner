# frozen_string_literal: true

class Baseliner::Models::Project
  attr_accessor :path

  def initialize(path:)
    self.path = path
  end

  def project_config_path
    File.join(path, "baseliner.yml")
  end

  def config
    @config ||= YAML.load_file(project_config_path, symbolize_names: true)
  end

  def name
    config.fetch(:project_name)
  end

  def check_enabled?(check)
    checks_config.fetch(check.name.to_sym).fetch(:enabled)
  end

  def checks_config
    config.fetch(:checks)
  end

  def to_h
    { name:, path: }
  end
end
