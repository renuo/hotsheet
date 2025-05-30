# frozen_string_literal: true

module Hotsheet
  class Engine < ::Rails::Engine
    isolate_namespace Hotsheet

    initializer "hotsheet.assets" do |app|
      app.config.assets.precompile += %w[hotsheet/application.css hotsheet/application.js]
    end
  end
end
