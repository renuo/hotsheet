# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Sheet do
  fixtures :users

  let(:sheet) { described_class.new :User }

  describe "#initialize" do
    it "constantizes the model name" do
      expect(sheet.model).to eq User
    end

    context "with nonexistent model" do
      let(:sheet) { described_class.new :Author }

      it "raises an error" do
        expect { sheet }.to raise_error "Unknown model 'Author'"
      end
    end
  end

  describe "#human_name" do
    it "reads the human name from the locales" do
      expect(sheet.human_name).to eq "Users"
    end
  end

  describe "#column" do
    let(:columns) { sheet.instance_variable_get(:@columns) }

    it "creates a column" do
      expect { sheet.column(:name) }.to change(columns, :length).by(1)
      expect(columns.last).to be_a Hotsheet::Sheet::Column
    end
  end

  describe "#columns" do
    before { sheet.column :name, visible: false }

    it "only returns visible columns" do
      expect(sheet.columns).to eq([])
    end
  end
end
