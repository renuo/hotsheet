# frozen_string_literal: true

require "hotsheet/version"
require "hotsheet/engine"
require "hotsheet/config"
require "hotsheet/sheet"
require "hotsheet/column"

module Hotsheet
  class Error < StandardError; end

  class << self
    include Config

    CONFIG = {}.freeze

    attr_reader :config

    def configure(config = {}, &sheets)
      @config = [merge_config!(CONFIG, config), sheets]
      self
    end

    def sheets
      @sheets ||= begin
        @sheets = {}
        instance_eval(&@config.pop)
        @sheets
      end
    end

    def t(key)
      I18n.t key, scope: "hotsheet"
    rescue I18n::MissingTranslationData
      I18n.with_locale(:en) { I18n.t key, scope: "hotsheet" }
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
