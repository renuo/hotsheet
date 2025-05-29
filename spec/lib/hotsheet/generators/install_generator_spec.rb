# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../lib/generators/hotsheet/install_generator"

RSpec.describe Hotsheet::Generators::InstallGenerator do
  let(:generator) { described_class.new [], [], destination_root: Rails.root.join("tmp") }

  before do
    FileUtils.rm_rf Rails.root.join "tmp/config"
    FileUtils.mkdir_p Rails.root.join "tmp/config"
    Rails.root.join("tmp/config/routes.rb").write ""
  end

  it "creates the initializer and mounts the engine" do
    out = <<-STDOUT
      create  config/initializers/hotsheet.rb
       route  mount Hotsheet::Engine, at: :hotsheet
    STDOUT

    expect { generator.invoke_all }.to output(out).to_stdout
  end
end
