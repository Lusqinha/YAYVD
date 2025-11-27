# frozen_string_literal: true
require 'json'
require 'date'
require 'ostruct'

module Yayvd
  class Video
    attr_reader :url, :metadata

    def initialize(url, executor: Executor.new)
      @url = url
      @metadata = nil
      @executor = executor
    end

    def info
      return @metadata if @metadata

      output = run_command("--dump-json")
      raw_data = JSON.parse(output)
      
      @metadata = OpenStruct.new(
        title: raw_data["title"],
        duration: raw_data["duration"],
        views: raw_data["view_count"],
        uploader: raw_data["uploader"],
        upload_date: parse_date(raw_data["upload_date"]),
        formats: raw_data["formats"]
      )
    end

    def download_audio(path: nil)
      output_dir = path || Yayvd.configuration.default_download_path
      output_template = File.join(output_dir, "%(title)s.%(ext)s")

      # -f bestaudio: Best audio source
      # -x: Extract audio
      # --audio-format mp3: Convert to mp3
      # --audio-quality 0: Best VBR quality
      # --embed-metadata: Adds artist, title, etc to the file
      # --embed-thumbnail: Adds video thumbnail as album art
      args = "-f bestaudio -x --audio-format mp3 --audio-quality 0 --embed-metadata --embed-thumbnail -o \"#{output_template}\""

      run_command(args)
    end

    def download_video(quality: :best, path: nil)
      output_dir = path || Yayvd.configuration.default_download_path
      output_template = File.join(output_dir, "%(title)s.%(ext)s")

      # bestvideo+bestaudio/best: Best video and audio merged
      # --merge-output-format mp4: Ensure final container is mp4
      args = "-f \"bestvideo+bestaudio/best\" --merge-output-format mp4 -o \"#{output_template}\""

      run_command(args)
    end

    private

    def run_command(args)
      full_args = "#{args} \"#{@url}\""
      @executor.execute(full_args)
    end

    def parse_date(date_str)
      Date.parse(date_str) rescue nil
    end
  end
end