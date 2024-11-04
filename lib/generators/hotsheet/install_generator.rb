# frozen_string_literal: true

require "rails/generators/migration"

module Hotsheet
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path "../templates", __dir__

      def copy_initializer
        template "hotsheet.rb", "config/initializers/hotsheet.rb"
      end

      def mount_engine
        route "mount Hotsheet::Engine, at: :hotsheet"
      end
    end
  end
end
