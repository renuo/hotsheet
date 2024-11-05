# frozen_string_literal: true

class TableNameTest < ApplicationRecord
  self.table_name = "different_db_name"
end
