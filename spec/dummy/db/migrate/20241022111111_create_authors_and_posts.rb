# frozen_string_literal: true

class CreateAuthorsAndPosts < ActiveRecord::Migration[6.1]
  def change
    authors
    posts
  end

  private

  def authors
    create_table :authors do |t|
      t.string :name
      t.date :birthdate
      t.string :gender
      t.timestamps
    end
  end

  def posts
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.references :author, foreign_key: true
      t.timestamps
    end
  end
end
