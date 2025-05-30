# frozen_string_literal: true

class Hotsheet::Engine < Rails::Engine
  isolate_namespace Hotsheet

  if config.respond_to? :assets
    config.assets.paths << Hotsheet::Engine.root.join("app/assets")
  end
end
