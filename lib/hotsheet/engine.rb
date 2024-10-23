# frozen_string_literal: true

module Hotsheet
  class Engine < ::Rails::Engine
    isolate_namespace Hotsheet

    config.assets.precompile += %w[hotsheet/application.css hotsheet/application.js]
  end
end
