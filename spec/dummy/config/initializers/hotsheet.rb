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
    row :display_name
    row :handle
    row :birthdate, visible: ->(current_user) { current_user.admin? }
    row :admin
    row :status
    row :created_at
    row :updated_at
  end
end
