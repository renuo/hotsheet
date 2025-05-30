# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Sheet do
  let(:sheet) { described_class.new :User, config, &columns }
  let(:config) { {} }
  let(:columns) { ->(_) {} }

  it "includes the id by default" do
    expect(sheet.model).to eq User
    expect(sheet.columns.keys).to eq %w[id]
  end

  context "without config" do
    let(:sheet) { described_class.new :User, config }

    it "includes all columns" do
      expect(sheet.columns.keys).to eq %w[id name handle email birthdate
                                          admin status created_at updated_at]
    end
  end

  context "with nonexistent column" do
    let(:columns) { ->(_) { column :age } }

    it "raises an error" do
      expect { sheet.column :age }.to raise_error(/Column must be one of/)
    end
  end

  describe "#columns" do
    let(:columns) { ->(_) { column :name, visible: false } }

    it "only returns visible columns" do
      expect(sheet.columns.keys).to eq %w[id]
      expect(sheet.instance_variable_get(:@columns).keys).to eq %w[id name]
    end
  end
end
