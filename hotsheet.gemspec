# frozen_string_literal: true

require_relative "lib/hotsheet/version"

Gem::Specification.new do |spec|
  spec.name = "hotsheet"
  spec.version = Hotsheet::VERSION
  spec.authors = ["Renuo AG"]
  spec.email = %w[ignacio.sfeir@renuo.ch simon.isler@renuo.ch eduard.munteanu@renuo.ch chris.hunziker@renuo.ch]
  spec.license = "MIT"

  spec.summary = "Manage your database with a simple and familiar web interface"
  spec.description = "This gem allows you to mount a view to manage your database using a" \
                     "table view where you can edit DB records inline."
  spec.homepage = "https://github.com/renuo/hotsheet"
  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => "#{spec.homepage}/blob/main/README.md",
    "rubygems_mfa_required" => "true"
  }
  spec.files = Dir["{app,config,lib,vendor}/**/*.*", "CHANGELOG.md", "LICENSE", "README.md"]

  spec.required_ruby_version = ">= 3.0.0"
  spec.add_dependency "rails", ">= 6.1.0"
  spec.add_dependency "pagy"
  spec.add_dependency "sprockets-rails"
  spec.add_dependency "stimulus-rails"
  spec.add_dependency "turbo-rails"
end
