# frozen_string_literal: true

require "rails_db_manager/version"
require "rails_db_manager/engine"
require "rails_db_manager/configuration"

module RailsDbManager
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def models
      configuration.models.each_key.map { |model| model.to_s.constantize }
    end
  end
end
