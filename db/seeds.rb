# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@list_titles = ["Family friendly", "Fast food", "Food trucks", "Pop-ups", "First date", "cheap n easy", "Birthday dinner", "Cheap eats", "Fancy schmancy", "Fine dining", "Romantic", "Best of 2018", "Personal favourites", "The Classics!"]

5.times do
  @user = User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length = 6, max_length = 12),
    name: Faker::Name.name
  )
  List.create(user_id: @user.id, title: @list_titles.sample)
end

10.times do
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

@dish_count = Dish.all.count
@list_count = List.all.count

(@dish_count * 2).times do
  ListItem.create(
    list_id: rand(1..@list_count),
    dish_id: rand(1..@dish_count)
  )
end
