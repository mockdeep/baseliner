# frozen_string_literal: true

class Baseliner::Models::Project
  attr_accessor :name, :path

  def initialize(name:, path:)
    self.name = name
    self.path = path
  end

  def to_h
    { name:, path: }
  end
end
