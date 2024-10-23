# frozen_string_literal: true

require_relative "lib/hotsheet/version"

Gem::Specification.new do |spec|
  spec.name = "hotsheet"
  spec.version = Hotsheet::VERSION
  spec.authors = ["Renuo AG"]
  spec.email = [
    "ignacio.sfeir@renuo.ch", "simon.isler@renuo.ch", "eduard.munteanu@renuo.ch", "chris.hunziker@renuo.ch"
  ]

  spec.summary = "Manage your database with a simple and familiar web interface"
  spec.description = "This gem allows you to mount a view to manage your database using a" \
                     "table view where you can edit DB records inline."
  spec.homepage = "https://github.com/renuo/hotsheet"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "#{spec.homepage}/blob/main/README.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.1.4"
  spec.add_dependency "rails", ">= 7.2.1"
  spec.add_dependency "sprockets-rails"
  spec.add_dependency "stimulus-rails"
  spec.add_dependency "turbo-rails"
end
