# frozen_string_literal: true

require "hotsheet/config"
require "hotsheet/engine"
require "hotsheet/sheet"
require "hotsheet/sheet/column"
require "hotsheet/version"

module Hotsheet
  class Error < StandardError; end

  class << self
    def configure(&config)
      @config = config
    end

    def sheets
      @sheets ||= Config.new.tap { |c| c.instance_eval(&@config) }.sheets
    end
  end
end
