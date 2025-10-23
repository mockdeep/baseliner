# frozen_string_literal: true

# module to display spinners in the terminal
module Baseliner::Spin
  class << self
    SPINNERS = YAML.load_file(File.join(__dir__, "spinners.yml")).map(&:cycle)

    # Displays a spinner in the terminal while the given thread is alive.
    def call(thread)
      while thread.alive?
        # hide cursor, clear line, and print spinner frame
        print("\e[?25l\r#{SPINNERS.map(&:next).join(" ")}")
        sleep(0.1)
      end

      # show cursor and clear line
      print("\e[?25h\r")
    end
  end
end
