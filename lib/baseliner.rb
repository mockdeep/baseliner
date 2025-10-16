# frozen_string_literal: true

require_relative "baseliner/version"

module Baseliner
  class Error < StandardError; end
end

require_relative "baseliner/run"
