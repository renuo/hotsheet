# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet do
  let(:config) { described_class.configure { sheet :User } }

  before do
    described_class.instance_variable_set :@sheets, nil
    config
  end

  it "configures hotsheet" do
    expect(config.sheets["users"].columns).not_to be_empty
  end

  context "with nonexistent sheet" do
    let(:config) { described_class.configure { sheet :Author } }

    it "raises an error" do
      expect { config.sheets }.to raise_error "Unknown model 'Author'"
    end
  end
end
