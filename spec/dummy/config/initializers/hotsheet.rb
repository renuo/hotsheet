# frozen_string_literal: true

Hotsheet.configure do
  sheet :Post do
    column :id, editable: false
    column :title
    column :body
    column :user_id
    column :created_at
    column :updated_at
  end

  sheet :Tag

  sheet :User do
    column :id, editable: false
    column :name
    column :handle, editable: false
    column :email
    column :birthdate
    column :admin
    column :status
    column :created_at, visible: false
    column :updated_at
  end
end
