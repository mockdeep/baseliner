# frozen_string_literal: true

module Baseliner::Checks; end

require_relative "checks/bundle_outdated"
require_relative "checks/rubocop_todos"
require_relative "checks/simple_cov"

module Baseliner::Checks
  ALL = [
    Baseliner::Checks::SimpleCov,
    Baseliner::Checks::BundleOutdated,
    Baseliner::Checks::RubocopTodos,
  ].freeze
end
