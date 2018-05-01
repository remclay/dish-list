# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create users
5.times do
  @user = User.create(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: Faker::Internet.password(min_length = 6, max_length = 20),
  )
  @list = List.create(user_id: @user.id)
end

# Create restaurants and dishes
10.times do
  @restaurant = Restaurant.create(
    name: Faker::Food.spice,
    cuisine: Faker::Address.country,
    location: Faker::Address.city
  )
    rand(1..4).times do Dish.create(
      name: Faker::Food.dish,
      restaurant_id: @restaurant.id,
      popularity: rand(1..10)
    )
    end
end

@dishes = Dish.all
@user_count = User.count

# Create ListItems
@dishes.each do |dish|
  ListItem.create(
    list_id: rand(1..@user_count),
    dish_id: dish.id,
    tasted: [true, false].sample
  )
end

# Create Demo user, with unique ListItems
@demo_user = User.create(email: "john@example.com", name: "John Doe", password: "testing")
@demo_list = List.create(user_id: @demo_user.id)
dish_ids = Array.new(10) { rand(1...@dishes.count) }
dish_ids.uniq.each do |id|
  ListItem.create(
    list_id: @demo_list.id,
    dish_id: id,
    tasted: [true, false].sample
  )
end
