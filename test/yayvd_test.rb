# frozen_string_literal: true

require "test_helper"

class YayvdTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Yayvd::VERSION
  end

  def test_it_can_be_configured
    Yayvd.configure do |config|
      config.yt_dlp_path = "/custom/path/yt-dlp"
    end

    assert_equal "/custom/path/yt-dlp", Yayvd.configuration.yt_dlp_path
  end
end
