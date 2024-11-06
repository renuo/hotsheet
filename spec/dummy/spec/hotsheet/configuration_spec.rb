# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Hotsheet::Configuration" do
  let(:config) do
    Hotsheet.configure do |config|
      config.model :Author do |model|
        model.included_attributes = %i[name birthdate]
        model.excluded_attributes = %i[created_at]
      end
    end
  end

  it "has included and excluded attributes" do
    expect(config).to be_a Hotsheet::Configuration::ModelConfig
    expect(config.included_attributes).to eq %i[name birthdate]
    expect(config.excluded_attributes).to eq %i[created_at]
  end

  it "doesn't have any other model configs" do # rubocop:disable RSpec/ExampleLength
    expect do
      Hotsheet.configure do |config|
        config.model :Author do |model|
          model.attributes = %i[name birthdate]
        end
      end
    end.to raise_error NoMethodError
  end
end
