# frozen_string_literal: true

require "spec_helper"

RSpec.describe Hotsheet::SheetsController do
  fixtures :users

  let(:user) { users(:admin) }

  before { prepare { Hotsheet.configure { sheet :User } } }

  it "updates the cell value" do
    visit hotsheet.users_path
    find(".cell", text: user.name).click.send_keys(:enter).fill_in(with: "Admin").send_keys :enter

    expect { find(".cell", text: user.email).click }
      .to change { user.reload.name }.from("Admin User").to "Admin"
  end
end
