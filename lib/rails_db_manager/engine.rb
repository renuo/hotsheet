# frozen_string_literal: true

module RailsDbManager
  class Engine < ::Rails::Engine
    isolate_namespace RailsDbManager

    config.assets.precompile += %w[rails_db_manager/application.css]
  end
end
