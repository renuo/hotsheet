# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Config do
  let(:config) { Hotsheet.configure { nil } }
  let(:sheet) { sheets["posts"] }
  let(:sheets) { Hotsheet.sheets }

  before do
    stub_const "Rails::Server", true
    config
    Rails.application.config.to_prepare_blocks.each(&:call)
  end

  describe "#sheet" do
    context "without config" do
      it "does not configure anything" do
        expect(sheets).to be_empty
      end
    end

    context "without rows" do
      let(:config) { Hotsheet.configure { sheet :Post } }

      it "uses all database columns" do
        expect(sheet).to be_a Hotsheet::Sheet
        expect(sheet.model).to eq Post
        expect(sheet.rows.pluck(:name)).to eq %i[id title body user_id created_at updated_at]
      end
    end

    context "with rows" do
      let(:config) do
        Hotsheet.configure do
          sheet :Post do
            row :title
            row :body
          end
        end
      end

      it "keeps the rows in the correct order" do
        expect(sheet.rows.pluck(:name)).to eq(%i[title body])
      end
    end

    context "with visibility" do
      let(:config) do
        Hotsheet.configure do
          sheet :Post do
            row :title, visible: false
            row :body
          end
        end
      end

      it "does not show the hidden rows" do
        expect(sheet.rows.pluck(:name)).to eq %i[body]
      end
    end
  end
end
