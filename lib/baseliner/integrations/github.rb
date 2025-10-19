# frozen_string_literal: true

module Baseliner::Integrations::Github
  class << self
    include Baseliner::Helpers

    def latest_build_id
      gh_run("list -b main --json databaseId -L 1 -q .[].databaseId")
    end

    def download_artifact(run_id, artifact_name)
      gh_run("download #{run_id.strip} -n #{artifact_name} -D #{artifact_name}")
    end

    def gh_run(command)
      run_or_raise("gh run #{command}")
    end
  end
end
