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

  describe "#row" do
    let(:rows) { sheet.instance_variable_get(:@rows) }

    it "creates a row" do
      expect { sheet.row(:name) }.to change(rows, :length).by(1)
      expect(rows.last).to be_a Hotsheet::Sheet::Row
    end
  end

  describe "#rows" do
    before { sheet.row :name, visible: false }

    it "only returns visible rows" do
      expect(sheet.rows).to eq([])
    end
  end
end
