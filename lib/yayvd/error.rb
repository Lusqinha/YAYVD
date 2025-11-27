# frozen_string_literal: true

module Yayvd
  class Error < StandardError
    module Messages
      YT_DLP_EXECUTION_FAILED = "Failed to execute yt-dlp"
      YT_DLP_NOT_FOUND = "yt-dlp not found. Please install it to use this gem."
    end
  end

  class ExecutionError < Error; end
  class DependencyError < Error; end
end
