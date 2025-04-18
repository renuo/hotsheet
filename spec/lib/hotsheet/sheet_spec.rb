# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::Sheet do
  let(:sheet) { described_class.new :Post }

  describe "#initialize" do
    it "constantizes the model name" do
      expect(sheet.model).to eq Post
    end

    context "with nonexistent model" do
      let(:sheet) { described_class.new :Author }

      it "raises an error" do
        expect { sheet }.to raise_error "Unknown model 'Author'"
      end
    end
  end

  describe "#row" do
    it "is editable and visible by default" do
      expect(sheet.row(:title)).to contain_exactly(name: :title, editable: true, visible: true)
    end

    context "with invalid config" do
      it "raises an error" do
        expect { sheet.row(:title, editable: true) }
          .to raise_error "Invalid config 'editable' for row 'title'"
      end
    end

    context "with nonexistent config" do
      it "raises an error" do
        expect { sheet.row(:title, readonly: true) }
          .to raise_error "Unknown config 'readonly' for row 'title'"
      end
    end

    context "with nonexistent database column" do
      it "raises an error" do
        expect { sheet.row(:content) }.to raise_error "Unknown database column 'content' for 'posts'"
      end
    end
  end

  describe "#rows" do
    let(:sheet) do
      sheet = described_class.new :Post
      sheet.row :title
      sheet
    end

    it "has a label, name, and is editable and visible by default" do
      expect(sheet.rows).to contain_exactly(
        label: "Title", name: :title, editable: true, visible: true
      )
    end
  end

  describe "#human_name" do
    it "reads the human name from the locales" do
      expect(sheet.human_name).to eq I18n.t "activerecord.models.post.other"
    end
  end
end
