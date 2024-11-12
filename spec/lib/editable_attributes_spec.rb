# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet" do
  describe ".editable_attributes_for" do
    subject(:editable_attributes) { Hotsheet.editable_attributes_for(model: Author) }

    before do
      Hotsheet.instance_variable_set(:@editable_attributes_for, nil) # reset the memoized editable attributes
    end

    context "when included attributes are specified" do
      before do
        Hotsheet.configure do |config|
          config.model :Author do |model|
            model.included_attributes = %i[name birthdate]
          end
        end
      end

      it "returns only the included attributes" do
        expect(editable_attributes).to eq %w[name birthdate]
      end
    end

    context "when excluded attributes are specified" do
      before do
        Hotsheet.configure do |config|
          config.model :Author do |model|
            model.excluded_attributes = %i[gender created_at updated_at]
          end
        end
      end

      it "returns all attributes except the excluded ones" do
        expect(editable_attributes).to eq %w[id name birthdate]
      end
    end

    context "when no included or excluded attributes are specified" do
      before do
        Hotsheet.configure do |config|
          config.model :Author
        end
      end

      it "returns all attributes of the model" do
        expect(Hotsheet.configuration.models["Author"]).to be_a Hotsheet::Configuration::ModelConfig
        expect(editable_attributes).to eq %w[id name birthdate gender created_at updated_at]
      end
    end
  end
end
