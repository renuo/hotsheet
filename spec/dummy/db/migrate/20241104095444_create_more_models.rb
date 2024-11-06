# frozen_string_literal: true

class CreateMoreModels < ActiveRecord::Migration[6.1]
  def change
    overflow_test
    different_db_name
  end

  private

  def overflow_test
    create_table :very_long_model_name_for_overflow_tests do |t|
      t.string :even_longer_column_name_for_overflow_test
      t.timestamps
    end
  end

  def different_db_name
    create_table :different_db_name do |t|
      t.string :title
      t.timestamps
    end
  end
end
