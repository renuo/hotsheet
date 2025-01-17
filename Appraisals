# frozen_string_literal: true

appraise "rails_7_0" do
  gem "rails", "~> 7.0.0"
  gem 'concurrent-ruby', "1.3.4" # https://github.com/rails/rails/issues/54260

  group :test do
    gem "sqlite3", "~> 1.4"
  end
end

appraise "rails_7_1" do
  gem "rails", "~> 7.1.0"

  group :test do
    gem "sqlite3", "~> 1.4"
  end
end

appraise "rails_7_2" do
  gem "rails", "~> 7.2.0"
end

appraise "rails_8_0" do
  gem "rails", "8.0.0.rc2"
end
