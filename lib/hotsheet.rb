# frozen_string_literal: true

require "sprockets/railtie"
require "turbo-rails"

require "hotsheet/engine"
require "hotsheet/version"
require "hotsheet/configuration"

module Hotsheet
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure(&block)
      @configuration = Configuration.new.tap(&block)
    end

    def models
      @models ||= configuration.models.each_key.map(&:constantize)
    end
  end
end
