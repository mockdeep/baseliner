# frozen_string_literal: true

module Baseliner::Run
  class << self
    def call(_args)
      Baseliner::Checks::RSpecCoverage.call
    end
  end
end
