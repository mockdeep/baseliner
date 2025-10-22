class Baseliner::Register
  class << self
    def call
      unless File.exist?(File.join(Dir.pwd, "baseliner.yml"))
        abort "No baseliner.yml found in the current directory. " \
          "Run 'baseliner init' first."
      end

      Baseliner.config[:paths] =
        Baseliner.registered_paths.push(Dir.pwd).uniq.sort
      Baseliner.save_config
    end
  end
end
