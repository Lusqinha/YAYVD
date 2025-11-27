# frozen_string_literal: true

require_relative "lib/yayvd/version"

Gem::Specification.new do |spec|
  spec.name = "yayvd"
  spec.version = Yayvd::VERSION
  spec.authors = ["Lucas"]
  spec.email = ["lucas@example.com"]

  spec.summary = "Yet Another Youtube Video Downloader - A robust Ruby wrapper for yt-dlp"
  spec.description = "A simple Ruby interface for downloading YouTube videos and audio using yt-dlp."
  spec.homepage = "https://github.com/Lusqinha/YAYVD"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
