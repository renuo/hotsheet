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

  it "is named after the table by default" do
    expect(sheet.name).to eq "users"
  end

  context "with an `as` option" do
    let(:config) { { as: :admins } }

    it "uses it as the name and label" do
      expect(sheet.name).to eq "admins"
      expect(sheet.label).to eq "Admins"
    end
  end

  describe "#scoped" do
    it "returns the model without a scope" do
      expect(sheet.scoped).to eq User
    end

    context "with a scope" do
      let(:config) { { scope: -> { where(admin: true) } } }

      it "applies it to the model" do
        expect(sheet.scoped.to_sql).to eq User.where(admin: true).to_sql
      end
    end
  end

  context "without config" do
    let(:sheet) { described_class.new :User }

    it "includes all columns" do
      expect(sheet.columns.keys).to match_array %w[id admin birthdate created_at email
                                                   handle name status updated_at]
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
