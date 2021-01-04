# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email

  User.create(
    nickname: name,
    email: email,
    password: "123abc"
  )
end

100.times do |n|
  title = Faker::Name.name
  text = Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false)
  category_id = Faker::Number.between(from: 0, to: 12)
  user_id = Faker::Number.between(from: 0, to: 103)

  Article.create(
    title: title,
    text: text,
    category_id: category_id,
    user_id: user_id
  )
end