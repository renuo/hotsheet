# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Column do
  let(:column) { described_class.new config }
  let(:config) { {} }

  it "is editable and visible by default" do
    expect(column.editable?).to be true
    expect(column.visible?).to be true
  end

  context "with config" do
    let(:config) { { editable: false, visible: -> { 0 == 1 } } }

    it "overrides the default" do
      expect(column.editable?).to be false
      expect(column.visible?).to be false
    end
  end

  context "with invalid config" do
    let(:config) { { editable: "no" } }

    it "raises an error" do
      expect { column }.to raise_error(/Config 'editable' must be/)
    end
  end

  context "with nonexistent config" do
    let(:config) { { readonly: true } }

    it "raises an error" do
      expect { column }.to raise_error(/Config must be one of/)
    end
  end
end
