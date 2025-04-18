# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet::VERSION" do
  it "has a semver version number" do
    expect(Hotsheet::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
  end
end
