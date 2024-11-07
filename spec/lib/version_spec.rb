# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet::VERSION" do
  it "has a version number" do
    expect(Hotsheet::VERSION).not_to be_nil
  end
end
