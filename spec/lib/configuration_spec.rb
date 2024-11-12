# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet::Configuration" do
  subject(:config) { Hotsheet.configuration }

  context "without model configuration" do
    before { Hotsheet.configure {} } # reset configuration

    it "does NOT have any configured model" do
      expect(config.models).to eq({})
    end
  end

  context "with a valid model configuration" do
    let(:model_config) { config.models["Author"] }

    before do
      Hotsheet.configure do |config|
        config.model :Author do |model|
          model.included_attributes = %i[name birthdate]
        end
      end
    end

    it "stores a list of configured models" do
      expect(config.models.length).to eq 1
      expect(config.models["Author"]).to be_a Hotsheet::Configuration::ModelConfig
    end

    it "has included attributes set correctly" do
      expect(model_config).to be_a Hotsheet::Configuration::ModelConfig
      expect(model_config.included_attributes).to eq %i[name birthdate]
    end
  end

  describe "Hotsheet::Configuration::ModelConfig" do
    subject(:model_config) { Hotsheet::Configuration::ModelConfig.new("Author") }

    let(:model_class) do
      Class.new do
        def self.name
          "Author"
        end

        def self.column_names
          %w[id name birthdate created_at updated_at]
        end
      end
    end

    before do
      stub_const("Author", model_class)
    end

    context "when only included attributes are specified" do
      before { model_config.included_attributes = %i[name birthdate] }

      it "validates without errors" do
        expect { model_config.validate! }.not_to raise_error
      end
    end

    context "when only excluded attributes are specified" do
      before { model_config.excluded_attributes = %i[created_at updated_at] }

      it "validates without errors" do
        expect { model_config.validate! }.not_to raise_error
      end
    end

    context "when both included and excluded attributes are specified" do
      before do
        model_config.included_attributes = %i[name birthdate]
        model_config.excluded_attributes = %i[created_at]
      end

      it "raises an error" do
        expect do
          model_config.validate!
        end.to raise_error("Can only specify either included or excluded attributes for 'Author'")
      end
    end

    context "when included attributes contain a non-existent attribute" do
      before { model_config.included_attributes = %i[name non_existent_attribute] }

      it "raises an error indicating the attribute does not exist" do
        expect do
          model_config.validate!
        end.to raise_error("Attribute 'non_existent_attribute' doesn't exist on model 'Author'")
      end
    end

    context "when excluded attributes contain a non-existent attribute" do
      before { model_config.excluded_attributes = %i[non_existent_attribute] }

      it "raises an error indicating the attribute does not exist" do
        expect do
          model_config.validate!
        end.to raise_error("Attribute 'non_existent_attribute' doesn't exist on model 'Author'")
      end
    end

    context "when no included or excluded attributes are specified" do
      it "validates without errors" do
        expect { model_config.validate! }.not_to raise_error
      end
    end
  end
end
