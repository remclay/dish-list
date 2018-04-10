# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length = 6, max_length = 12)
  )
end

3.times do
  Restaurant.create(
    name: Faker::Food.spice,
    cuisine: Faker::Address.country,
    location: Faker::Address.city
  )
end

@restaurant_count = Restaurant.all.count

(@restaurant_count * 2).times do
  Dish.create(
    name: Faker::Food.dish,
    restaurant_id: rand(1..@restaurant_count)
  )
end
