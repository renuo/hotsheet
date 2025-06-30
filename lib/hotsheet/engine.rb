# frozen_string_literal: true

class Hotsheet::Engine < Rails::Engine
  isolate_namespace Hotsheet

  initializer "hotsheet.assets" do |app|
    app.config.assets.paths << Hotsheet::Engine.root.join("app/assets")
    app.config.assets.precompile += %w[hotsheet.css hotsheet.js]
  end
end
