# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Config do
  let(:config) { Hotsheet.configure { nil } }
  let(:sheet) { sheets["users"] }
  let(:sheets) { Hotsheet.sheets }

  before do
    Hotsheet.instance_variable_set :@sheets, nil
    config
  end

  describe "#sheet" do
    context "without config" do
      it "does not configure anything" do
        expect(sheets).to be_empty
      end
    end

    context "without columns" do
      let(:config) { Hotsheet.configure { sheet :User } }

      it "uses all database columns" do
        expect(sheet).to be_a Hotsheet::Sheet
        expect(sheet.columns.map(&:name)).to eq User.column_names
      end
    end

    context "with columns" do
      let(:config) do
        Hotsheet.configure do
          sheet :User do
            column :email
            column :name
          end
        end
      end

      it "keeps the columns in the correct order" do
        expect(sheet.columns.map(&:name)).to eq(%w[id email name])
      end
    end
  end
end
