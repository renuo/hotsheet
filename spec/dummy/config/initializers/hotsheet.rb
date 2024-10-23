# frozen_string_literal: true

Hotsheet.configure do |config|
  config.model :Author do |model|
    model.included_attributes = %i[name birthdate gender updated_at]
  end

  config.model :Post do |model|
    model.excluded_attributes = %i[id author_id created_at updated_at]
  end
end
