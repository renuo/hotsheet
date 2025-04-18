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

  describe "#row" do
    it "is editable and visible by default" do
      expect(sheet.row(:name)).to contain_exactly(name: :name, editable: true, visible: true)
    end

    context "with invalid config" do
      it "raises an error" do
        expect { sheet.row(:name, editable: true) }
          .to raise_error "Invalid config 'editable' for row 'name'"
      end
    end

    context "with nonexistent config" do
      it "raises an error" do
        expect { sheet.row(:name, readonly: true) }
          .to raise_error "Unknown config 'readonly' for row 'name'"
      end
    end

    context "with nonexistent database column" do
      it "raises an error" do
        expect { sheet.row(:age) }.to raise_error "Unknown database column 'age' for 'users'"
      end
    end
  end

  describe "#rows" do
    let(:sheet) do
      sheet = described_class.new :User
      sheet.row :name
      sheet
    end

    it "has a label, name, and is editable and visible by default" do
      expect(sheet.rows).to contain_exactly(
        label: "Name", name: :name, editable: true, visible: true
      )
    end
  end

  describe "#human_name" do
    it "reads the human name from the locales" do
      expect(sheet.human_name).to eq I18n.t "activerecord.models.user.other"
    end
  end

  describe "#update!" do
    let(:user) { users(:admin) }
    let(:row) { sheet.row :admin }

    before { row }

    it "updates the model" do
      expect { sheet.update!(id: user.id, attr: :admin, value: false) }
        .to change { user.reload.admin? }.from(true).to(false)
    end

    context "when row is readonly" do
      let(:row) { sheet.row :admin, editable: false }

      it "raises an error" do
        expect { sheet.update!(id: user.id, attr: :admin, value: false) }.to raise_error "Forbidden"
      end
    end
  end
end
