# frozen_string_literal: true

require "test_helper"
require "minitest/mock"
require "ostruct"
require "date"

class Yayvd::VideoTest < Minitest::Test
  def setup
    @url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    @video = Yayvd::Video.new(@url)

    Yayvd.configuration = nil
    Yayvd.configure { |c| c.yt_dlp_path = "yt-dlp" }
  end

  def test_info_parses_metadata_correctly
    json_output = {
      title: "Rick Astley - Never Gonna Give You Up",
      duration: 212,
      view_count: 1000000,
      uploader: "RickAstleyVEVO",
      upload_date: "20091025",
      formats: []
    }.to_json

    Open3.stub :capture3, [json_output, "", process_status_mock(true)] do
      metadata = @video.info

      assert_equal "Rick Astley - Never Gonna Give You Up", metadata.title
      assert_equal 212, metadata.duration
      assert_equal "RickAstleyVEVO", metadata.uploader
      assert_equal Date.new(2009, 10, 25), metadata.upload_date
    end
  end

  def test_download_audio_constructs_correct_command
    expected_args = "-f bestaudio -x --audio-format mp3 --audio-quality 0 --embed-metadata --embed-thumbnail -o \"#{Dir.pwd}/%(title)s.%(ext)s\""
    expected_cmd = "yt-dlp #{expected_args} \"#{@url}\""

    capture_mock = Minitest::Mock.new
    capture_mock.expect :call, ["", "", process_status_mock(true)], [expected_cmd]

    Open3.stub :capture3, capture_mock do
      @video.download_audio
    end

    capture_mock.verify
  end

  def test_download_video_constructs_correct_command
    expected_args = "-f \"bestvideo+bestaudio/best\" --merge-output-format mp4 -o \"#{Dir.pwd}/%(title)s.%(ext)s\""
    expected_cmd = "yt-dlp #{expected_args} \"#{@url}\""

    capture_mock = Minitest::Mock.new
    capture_mock.expect :call, ["", "", process_status_mock(true)], [expected_cmd]

    Open3.stub :capture3, capture_mock do
      @video.download_video
    end

    capture_mock.verify
  end

  def test_raises_error_on_failure
    Open3.stub :capture3, ["", "Error message", process_status_mock(false)] do
      error = assert_raises(Yayvd::ExecutionError) do
        @video.info
      end
      assert_match(/Failed to execute yt-dlp/, error.message)
    end
  end

  private

  def process_status_mock(success)
    obj = Object.new
    obj.define_singleton_method(:success?) { success }
    obj
  end
end
