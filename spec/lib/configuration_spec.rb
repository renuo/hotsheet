# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet::Configuration" do
  subject(:config) { Hotsheet.configuration }

  context "without model configuration" do
    before { Hotsheet.configure {} } # rubocop:disable Lint/EmptyBlock

    it "does NOT have any configured model" do
      expect(config.models).to eq({})
    end
  end

  context "with a model configuration" do
    let(:model_config) { config.models["Author"] }

    before do
      Hotsheet.configure do |config|
        config.model :Author do |model|
          model.included_attributes = %i[name birthdate]
          model.excluded_attributes = %i[created_at]
        end
      end
    end

    it "stores a list of configured models" do
      expect(config.models.length).to eq 1
      expect(config.models["Author"]).to be_a Hotsheet::Configuration::ModelConfig
    end

    it "has included and excluded attributes" do
      expect(model_config).to be_a Hotsheet::Configuration::ModelConfig
      expect(model_config.included_attributes).to eq %i[name birthdate]
      expect(model_config.excluded_attributes).to eq %i[created_at]
    end
  end
end
