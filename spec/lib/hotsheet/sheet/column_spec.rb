# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Sheet::Column do
  let(:config) { {} }
  let(:column) { described_class.new :name, config }

  describe "#initialize" do
    it "is visible and editable by default" do
      expect(column.visible?).to be true
      expect(column.editable?).to be true
    end

    context "with valid config" do
      let(:config) { { editable: false, visible: false } }

      it "does not raise an error" do
        expect(column.visible?).to be false
        expect(column.editable?).to be false
      end
    end

    context "with invalid config" do
      let(:config) { { editable: "no" } }

      it "raises an error" do
        expect { column }.to raise_error "Invalid config 'editable' for column 'name'"
      end
    end

    context "with nonexistent config" do
      let(:config) { { readonly: true } }

      it "raises an error" do
        expect { column }.to raise_error "Unknown config 'readonly' for column 'name'"
      end
    end
  end
end
