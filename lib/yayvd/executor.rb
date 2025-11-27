# frozen_string_literal: true

require "open3"

module Yayvd
  class Executor
    def execute(args)
      binary = Yayvd.configuration.yt_dlp_path
      cmd = "#{binary} #{args}"
      
      stdout, stderr, status = Open3.capture3(cmd)

      unless status.success?
        raise Yayvd::ExecutionError, "#{Yayvd::Error::Messages::YT_DLP_EXECUTION_FAILED}: #{stderr}"
      end

      stdout
    end
  end
end
