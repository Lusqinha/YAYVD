# frozen_string_literal: true

require_relative "yayvd/version"
require_relative "yayvd/config"
require_relative "yayvd/executor"
require_relative "yayvd/video"
require_relative "yayvd/error"

module Yayvd
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
