# frozen_string_literal: true

require "faker"

10.times do
  Author.create!(name: Faker::Name.name,
                 birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
                 gender: Author.genders.values.sample)
end

10.times do
  Post.create!(title: Faker::Lorem.word,
               body: Faker::Lorem.paragraph,
               author_id: Author.pluck(:id).sample)
end
