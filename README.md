# YAYVD (Yet Another Youtube Video Downloader)

[![Gem Version](http://img.shields.io/gem/v/yayvd.svg)](http://rubygems.org/gems/yayvd)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**YAYVD** is a developer-friendly Ruby wrapper for [yt-dlp](https://github.com/yt-dlp/yt-dlp). It simplifies the process of downloading videos and audio from YouTube, providing a clean Ruby API while leveraging the power and stability of `yt-dlp`.

Designed for both **Humans** (simple API, sensible defaults) and **AI Agents** (structured metadata, predictable errors).

## 🚀 Features

*   **Simple API:** Download video or audio with a single line of code.
*   **Smart Audio:** Automatically extracts high-quality audio, converts to MP3, and embeds metadata (Artist, Title, Cover Art).
*   **Rich Metadata:** Fetch video details (views, duration, upload date) without downloading the file.
*   **Reliable:** Built on top of `yt-dlp`, the industry standard for video extraction.
*   **Configurable:** Customize paths and binary locations easily.

## 📦 Installation

Add this line to your application's Gemfile:

```ruby
gem 'yayvd'
```

And then execute:

    $ bundle install

### System Dependencies

YAYVD requires `yt-dlp` and `ffmpeg` (for audio conversion) to be installed on your system.

**macOS (Homebrew):**
```bash
brew install yt-dlp ffmpeg
```

**Linux (Debian/Ubuntu):**
```bash
sudo apt update
sudo apt install yt-dlp ffmpeg
```

**Python (Universal):**
```bash
pip install yt-dlp
```

## 🛠 Usage

### Basic Usage

```ruby
require 'yayvd'

# Initialize with a YouTube URL
video = Yayvd::Video.new("https://www.youtube.com/watch?v=dQw4w9WgXcQ")

# 1. Get Metadata (Fast, no download)
info = video.info
puts "Title: #{info.title}"       # => "Rick Astley - Never Gonna Give You Up"
puts "Views: #{info.views}"       # => 123456789
puts "Date:  #{info.upload_date}" # => <Date: 2009-10-25>

# 2. Download Audio (High Quality MP3 + Metadata + Cover Art)
# Saves to current directory by default
video.download_audio

# 3. Download Video (Best Quality MP4)
video.download_video
```

### Advanced Configuration

You can configure download paths and binary locations globally:

```ruby
Yayvd.configure do |config|
  config.default_download_path = "/home/user/Downloads"
  config.yt_dlp_path = "/usr/local/bin/yt-dlp" # Optional: Custom binary path
end
```

### Custom Output Path per Download

```ruby
video.download_audio(path: "/tmp/music")
video.download_video(path: "/tmp/videos")
```

## 🤖 AI Context (For LLMs & Agents)

If you are an AI agent using this library, here is the mental model:

1.  **Class:** `Yayvd::Video` is the main entry point.
2.  **Initialization:** `Yayvd::Video.new(url)` is lightweight. It does not make network requests.
3.  **Metadata:** `.info` returns an `OpenStruct`. It caches the result, so calling it multiple times is safe.
4.  **Blocking:** `.download_audio` and `.download_video` are **blocking** operations. They shell out to `yt-dlp`.
5.  **Errors:**
    *   `Yayvd::ExecutionError`: Raised if `yt-dlp` fails (e.g., invalid URL, network error).
    *   `Yayvd::Error::Messages::YT_DLP_NOT_FOUND`: Raised if the binary is missing.

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Lusqinha/YAYVD.

## 📝 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
