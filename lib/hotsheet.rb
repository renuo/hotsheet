# frozen_string_literal: true

require "hotsheet/version"
require "hotsheet/engine"
require "hotsheet/config"

module Hotsheet
  autoload :Column, "#{__dir__}/hotsheet/column"
  autoload :Sheet, "#{__dir__}/hotsheet/sheet"

  class Error < StandardError; end

  class << self
    include Config

    attr_reader :config

    DEFAULT_CONFIG = {}.freeze

    def configure(config = {}, &sheets)
      @config = [merge_config!(DEFAULT_CONFIG, config), sheets]
      self
    end

    def sheets
      @sheets ||= begin
        @sheets = {}
        instance_eval(&@config.pop)
        @sheets
      end
    end

    I18N = Psych.load_file(Hotsheet::Engine.root.join("config/locales/en.yml"))["en"]["hotsheet"].freeze

    def t(key, **kwargs)
      I18n.t "hotsheet.#{key}", default: I18N[key], **kwargs
    end

    private

    def sheet(name, config = {}, &)
      ensure_sheet_exists! name

      sheet = Sheet.new(name, config, &)
      @sheets[sheet.model.table_name] = sheet
    end

    def ensure_sheet_exists!(name)
      return if Object.const_defined? name

      raise Hotsheet::Error, "Unknown model '#{name}'"
    end
  end
end
