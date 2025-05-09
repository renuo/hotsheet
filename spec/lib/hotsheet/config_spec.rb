# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Config do
  let(:config) { Hotsheet.configure { nil } }
  let(:sheet) { sheets["posts"] }
  let(:sheets) { Hotsheet.sheets }

  before { prepare { config } }

  describe "#sheet" do
    context "without config" do
      it "does not configure anything" do
        expect(sheets).to be_empty
      end
    end

    context "without columns" do
      let(:config) { Hotsheet.configure { sheet :Post } }

      it "uses all database columns" do
        expect(sheet).to be_a Hotsheet::Sheet
        expect(sheet.columns.map(&:name)).to eq %w[id title body user_id created_at updated_at]
      end
    end

    context "with columns" do
      let(:config) do
        Hotsheet.configure do
          sheet :Post do
            column :title
            column :body
          end
        end
      end

      it "keeps the columns in the correct order" do
        expect(sheet.columns.map(&:name)).to eq(%w[title body])
      end
    end
  end
end
