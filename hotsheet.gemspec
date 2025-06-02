# frozen_string_literal: true

require_relative "lib/hotsheet/version"

Gem::Specification.new do |s|
  s.name = "hotsheet"
  s.version = Hotsheet::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = "Renuo AG"
  s.email = %w[ignacio.sfeir@renuo.ch simon.isler@renuo.ch
               eduard.munteanu@renuo.ch chris.hunziker@renuo.ch]
  s.license = "MIT"
  s.summary = "Database GUI for Rails."
  s.description = "Manage your Rails database through a spreadsheet-like interface."

  s.homepage = "https://github.com/renuo/hotsheet"
  s.metadata = {
    "source_code_uri" => s.homepage,
    "bug_tracker_uri" => "#{s.homepage}/issues",
    "changelog_uri" => "#{s.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => "#{s.homepage}/blob/main/README.md",
    "rubygems_mfa_required" => "true"
  }
  s.files = Dir["app/{assets,controllers,helpers,views}/**/*.*",
                "{config,lib}/**/*.rb", "LICENSE", "README.md"]

  s.required_ruby_version = ">= 3.1.0"
  s.add_dependency "rails", ">= 6.1.0"
end
