# frozen_string_literal: true

IGNORED_GEMS = %w[appraisal better_errors binding_of_caller
                  brakeman erb_lint faker renuocop simplecov].freeze

NOT_DEFAULT_GEMS_IN_RUBY_3_4 = %w[benchmark bigdecimal drb mutex_m].freeze

appraise "rails_6_1" do
  gem "rails", "~> 6.1.0"
  gem "sprockets-rails"
  gem "sqlite3", "~> 1.7", require: false
  gem "tsort", require: false

  remove_gem "propshaft"
  NOT_DEFAULT_GEMS_IN_RUBY_3_4.each { |name| gem name }
  group(:development, :test) { IGNORED_GEMS.each { |name| remove_gem name } }
end

appraise "rails_7_0" do
  gem "rails", "~> 7.0.0"
  gem "sqlite3", "~> 1.7", require: false
  gem "tsort", require: false

  NOT_DEFAULT_GEMS_IN_RUBY_3_4.each { |name| gem name }
  group(:development, :test) { IGNORED_GEMS.each { |name| remove_gem name } }
end

appraise "rails_7_1" do
  gem "rails", "~> 7.1.0"

  group(:development, :test) { IGNORED_GEMS.each { |name| remove_gem name } }
end

appraise "rails_7_2" do
  gem "rails", "~> 7.2.0"

  group(:development, :test) { IGNORED_GEMS.each { |name| remove_gem name } }
end

if RUBY_VERSION.to_f >= 3.2
  appraise "rails_8_0" do
    gem "rails", "~> 8.0.0"
    gem "simplecov", require: false

    group(:development, :test) { IGNORED_GEMS.each { |name| remove_gem name } }
  end

  appraise "rails_8_1" do
    gem "rails", "~> 8.1.0"
    gem "simplecov", require: false

    group(:development, :test) { IGNORED_GEMS.each { |name| remove_gem name } }
  end
end
