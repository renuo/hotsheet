# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Sheet::Column do
  fixtures :users

  let(:config) { {} }
  let(:name) { :name }
  let(:column) { described_class.new User, name, config }

  describe "permissions" do
    it "is visible and editable by default" do
      expect(column.visible?).to be true
      expect(column.editable?).to be true
    end
  end

  describe "#human_name" do
    it "reads the human name from the locales" do
      expect(column.human_name).to eq "Name"
    end
  end

  describe "#validate!" do
    context "with nonexistent database column" do
      let(:name) { :age }

      it "raises an error" do
        expect { column.validate! }.to raise_error "Unknown database column 'age' for 'users'"
      end
    end

    context "with nonexistent config" do
      let(:config) { { readonly: true } }

      it "raises an error" do
        expect { column.validate! }.to raise_error "Unknown config 'readonly' for column 'name'"
      end
    end

    context "with invalid config" do
      let(:config) { { editable: "no" } }

      it "raises an error" do
        expect { column.validate! }.to raise_error "Invalid config 'editable' for column 'name'"
      end
    end
  end
end
