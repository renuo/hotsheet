# frozen_string_literal: true

require_relative "spec/dummy/config/application"

Rails.application.load_tasks

task build: :environment do
  sh "bun run build"
  sh "gem build"
end
