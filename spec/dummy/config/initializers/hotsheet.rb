# frozen_string_literal: true

Hotsheet.configure do
  sheet :Post do
    row :id, editable: false
    row :title
    row :body
    row :user_id
    row :created_at
    row :updated_at
  end

  sheet :Tag

  sheet :User do
    row :id, editable: false
    row :name
    row :handle
    row :email
    row :birthdate
    row :admin
    row :status
    row :created_at, visible: false
    row :updated_at
  end
end
