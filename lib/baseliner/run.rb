# frozen_string_literal: true

module Baseliner::Run
  class << self
    def call(args)
      puts "Baseliner version #{Baseliner::VERSION}"
      puts "Arguments: #{args.join(", ")}"
    end
  end
end
