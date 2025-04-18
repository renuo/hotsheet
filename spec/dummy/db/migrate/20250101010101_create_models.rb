# frozen_string_literal: true

class CreateModels < ActiveRecord::Migration[8.0]
  def change
    create_users
    create_posts
    create_tags
    create_post_tags
  end

  private

  def create_users
    create_table :users do |t|
      t.string :display_name, null: false
      t.string :handle, null: false, index: { unique: true }
      t.date :birthdate
      t.boolean :admin, null: false, default: false
      t.integer :status, null: false
      t.timestamps
    end
  end

  def create_posts
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end

  def create_tags
    create_table :tags do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.timestamps
    end
  end

  def create_post_tags
    create_table :post_tags do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true
    end
  end
end
