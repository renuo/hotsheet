# frozen_string_literal: true

require "spec_helper"

RSpec.describe "editable attributes", :js do
  let!(:author) { Author.create! name: "Stephen", birthdate: "1947-09-21", gender: "male" }

  describe "update strings" do
    before do
      Hotsheet.configure do |config|
        config.model :Author do |model|
          model.included_attributes = %i[name birthdate]
        end
      end
      Hotsheet.instance_variable_set(:@editable_attributes_for, nil) # reset the memoized editable attributes

      visit "/hotsheet"
      click_link "Author"

      fill_in "author_name", with: "King"
    end

    it "updates attribute when pressing enter" do
      find_by_id("author_name").native.send_keys :return

      expect(page).to have_field("author_name", with: "King")
      expect(author.reload.name).to eq("King")
    end

    it "updates attribute when clicking outside the input" do
      find("th", text: "name").click

      expect(page).to have_field("author_name", with: "King")
      expect(author.reload.name).to eq("King")
    end
  end
end
