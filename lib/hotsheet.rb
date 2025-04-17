# frozen_string_literal: true

require "hotsheet/config"
require "hotsheet/engine"
require "hotsheet/sheet"
require "hotsheet/version"

module Hotsheet
  class Error < StandardError; end

  class << self
    attr_accessor :sheets

    def configure(&config)
      Hotsheet.sheets = {}
      return unless config && defined? Rails::Server

      Rails.application.config.to_prepare do
        Hotsheet.sheets = Config.new.tap { |c| c.instance_eval(&config) }.sheets
      end
    end
  end
end
