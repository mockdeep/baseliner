# frozen_string_literal: true

module Baseliner::Integrations::Github
  class << self
    include Baseliner::Helpers

    def latest_build_id(path:)
      gh_run("list -b main --json databaseId -L 1 -q .[].databaseId", path:)
    end

    def download_artifact(path:, run_id:, name:)
      gh_run("download #{run_id.strip} -n #{name} -D #{name}", path:)
    end

    def gh_run(command, path:)
      run_or_raise("gh run #{command}", path:)
    end
  end
end
