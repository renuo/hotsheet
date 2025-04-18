# frozen_string_literal: true

IGNORED_GEMS = %w[appraisal better_errors binding_of_caller
                  brakeman erb_lint faker renuocop simplecov].freeze

appraise "rails_7_0" do
  gem "rails", "~> 7.0.0"
  gem "sqlite3", "~> 1.7", require: false

  # Not part of the default gems starting from Ruby 3.4
  gem "benchmark"
  gem "bigdecimal"
  gem "drb"
  gem "mutex_m"

  group(:development) { IGNORED_GEMS.each { |gem| remove_gem gem } }
end

appraise "rails_7_1" do
  gem "rails", "~> 7.1.0"

  group(:development) { IGNORED_GEMS.each { |gem| remove_gem gem } }
end

appraise "rails_7_2" do
  gem "rails", "~> 7.2.0"

  group(:development) { IGNORED_GEMS.each { |gem| remove_gem gem } }
end

if RUBY_VERSION.to_f >= 3.2
  appraise "rails_8_0" do
    gem "rails", "~> 8.0.0"
    gem "simplecov"

    group(:development) { IGNORED_GEMS.each { |gem| remove_gem gem } }
  end
end
