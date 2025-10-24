# frozen_string_literal: true

class Baseliner::Models::Project
  attr_accessor :path

  def initialize(path:)
    self.path = path
  end

  def project_config_path
    File.join(path, "baseliner.yml")
  end

  def project_config
    YAML.load_file(project_config_path)
  end

  def name
    project_config.fetch(:project_name)
  end

  def to_h
    { name:, path: }
  end
end
