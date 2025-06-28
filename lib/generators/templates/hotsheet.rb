# frozen_string_literal: true

# Configure the models to be used by Hotsheet.
# See https://github.com/renuo/hotsheet/blob/main/README.md#usage.

Hotsheet.configure do
  # Configure the visible and editable columns for each model.
  # The ID is included as the first column by default.
  # The number of rows displayed can be configured using the `per` option,
  # which defaults to 100.

  # sheet :User, per: 10 do
  #   column :name
  #   column :email, editable: false
  #   column :birthdate, editable: -> { rand > 0.5 }
  # end

  # Leave the block out to include all database columns.

  # sheet :Post
end
