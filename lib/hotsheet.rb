# frozen_string_literal: true

require "sprockets/railtie"
require "turbo-rails"

require "hotsheet/configuration"
require "hotsheet/engine"
require "hotsheet/version"

module Hotsheet
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def models
      @models ||= configuration.models.each_key.map(&:constantize)
    end
  end
end
