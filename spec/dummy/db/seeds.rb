# frozen_string_literal: true

require "faker"

10.times do
  User.create!(
    display_name: Faker::Name.name,
    handle: Faker::Internet.unique.username(specifier: 1..20),
    birthdate: Faker::Date.birthday,
    admin: Faker::Boolean.boolean(true_ratio: 0.25),
    status: User.statuses.keys.sample
  )
end

30.times do
  Post.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user_id: User.pluck(:id).sample
  )
end

5.times do
  Tag.create!(
    name: Faker::Music.genre.delete(" "),
    color: Faker::Color.hex_color.slice(1, 6),
    post_ids: Post.pluck(:id).sample(3)
  )
end
