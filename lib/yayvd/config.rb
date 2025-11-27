# frozen_string_literal: true

module Yayvd
  class Configuration
    attr_accessor :yt_dlp_path, :ffmpeg_path, :default_download_path

    def initialize
      @yt_dlp_path = "yt-dlp" # Tenta usar do PATH por padrão
      @ffmpeg_path = "ffmpeg"
      @default_download_path = Dir.pwd
    end
  end
end
