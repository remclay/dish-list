# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Create users and lists
@user_1 = User.create(email: "andrew_g@gmail.com", name: "Andrew G", password: "ilovefries")
@list_1 = List.create(user_id: @user_1.id)

@user_2 = User.create(email: "pastalover89@gmail.com", name: "Sally Robertson", password: "d0gs89")
@list_2 = List.create(user_id: @user_2.id)

@user_3 = User.create(email: "jessica-jones@hotmail.com", name: "Jessica J Jones", password: "br88$sr")
@list_3 = List.create(user_id: @user_3.id)

@user_4 = User.create(email: "drmotgomery@gmail.com", name: "Dr Jake Motgomery", password: "DontForget!")
@list_4 = List.create(user_id: @user_4.id)

@user_5 = User.create(email: "lauren@icloud.com", name: "Lauren Parks", password: "lparks94")
@list_5 = List.create(user_id: @user_5.id)

@user_6 = User.create(email: "john@example.com", name: "John Doe", password: "testing")
@list_6 = List.create(user_id: @user_6.id)

# Create restaurants and dishes
@restaurant_1 = Restaurant.create(name: "Cuba Cuba Cafe", cuisine: "Cuban", location: "Denver")
@dish_1 = Dish.create(name: "Empanadas", restaurant_id: @restaurant_1.id, popularity: rand(1..15))
@dish_2 = Dish.create(name: "Paella", restaurant_id: @restaurant_1.id, popularity: rand(1..15))
@dish_3 = Dish.create(name: "Camarones al coco", restaurant_id: @restaurant_1.id, popularity: rand(1..15))
@dish_4 = Dish.create(name: "Pescado Tropical", restaurant_id: @restaurant_1.id, popularity: rand(1..15))

@restaurant_2 = Restaurant.create(name: "Work & Class", cuisine: "American", location: "Denver")
@dish_5 = Dish.create(name: "Mac & Cheese", restaurant_id: @restaurant_2.id, popularity: rand(1..15))
@dish_6 = Dish.create(name: "Coriander Roasted Colorado Lamb", restaurant_id: @restaurant_2.id, popularity: rand(1..15))

@restaurant_3 = Restaurant.create(name: "Ian's Pizza", cuisine: "Pizza", location: "Denver")
@dish_7 = Dish.create(name: "Pepperoni Sausage Pizza", restaurant_id: @restaurant_3.id, popularity: rand(1..15))
@dish_8 = Dish.create(name: "BBQ Chicken Pizza", restaurant_id: @restaurant_3.id, popularity: rand(1..15))
@dish_9 = Dish.create(name: "Mushroom Madness Pizza", restaurant_id: @restaurant_3.id, popularity: rand(1..15))
@dish_10 = Dish.create(name: "Cheesy Potato & Ranch Pizza", restaurant_id: @restaurant_3.id, popularity: rand(1..15))

@restaurant_4 = Restaurant.create(name: "House and Home", cuisine: "Southern", location: "Chicago")
@dish_11 = Dish.create(name: "Fried Chicken and Waffles", restaurant_id: @restaurant_4.id, popularity: rand(1..15))

@restaurant_5 = Restaurant.create(name: "Dio Mio", cuisine: "Italian", location: "Denver")
@dish_12 = Dish.create(name: "Calamari", restaurant_id: @restaurant_5.id, popularity: rand(1..15))
@dish_13 = Dish.create(name: "Rigatoni", restaurant_id: @restaurant_5.id, popularity: rand(1..15))
@dish_14 = Dish.create(name: "Cacio e Pepe", restaurant_id: @restaurant_5.id, popularity: rand(1..15))
@dish_15 = Dish.create(name: "Gelato", restaurant_id: @restaurant_5.id, popularity: rand(1..15))

@restaurant_6 = Restaurant.create(name: "Los Tacos", cuisine: "Mexican", location: "New York City")
@dish_16 = Dish.create(name: "Carne Asada taco", restaurant_id: @restaurant_6.id, popularity: rand(1..15))
@dish_17 = Dish.create(name: "Adobada taco", restaurant_id: @restaurant_6.id, popularity: rand(1..15))
@dish_18 = Dish.create(name: "Quesadilla especial", restaurant_id: @restaurant_6.id, popularity: rand(1..15))
@dish_19 = Dish.create(name: "Chips y guacamole", restaurant_id: @restaurant_6.id, popularity: rand(1..15))

@restaurant_7 = Restaurant.create(name: "Emily", cuisine: "Pizza, burgers", location: "New York City")
@dish_20 = Dish.create(name: "Shredded sprouts", restaurant_id: @restaurant_7.id, popularity: rand(1..15))
@dish_21 = Dish.create(name: "Emmy Burger Double Stack", restaurant_id: @restaurant_7.id, popularity: rand(1..15))
@dish_22 = Dish.create(name: "Classic Round Pie", restaurant_id: @restaurant_7.id, popularity: rand(1..15))

@restaurant_8 = Restaurant.create(name: "Deadly Desert", cuisine: "Sweets", location: "Denver")
@dish_23 = Dish.create(name: "Chocolate mousse", restaurant_id: @restaurant_8.id, popularity: rand(1..15))
@dish_24 = Dish.create(name: "Pistachio cannoli", restaurant_id: @restaurant_8.id, popularity: rand(1..15))
@dish_25 = Dish.create(name: "Sorbet", restaurant_id: @restaurant_8.id, popularity: rand(1..15))

@restaurant_9 = Restaurant.create(name: "Pies n Thighs", cuisine: "Southern", location: "New York City")
@dish_26 = Dish.create(name: "Chicken & biscuits", restaurant_id: @restaurant_9.id, popularity: rand(1..15))

@restaurant_10 = Restaurant.create(name: "Meadowlark Kitchen", cuisine: "American", location: "Denver")
@dish_27 = Dish.create(name: "Wild Mushrooms Bowl", restaurant_id: @restaurant_10.id, popularity: rand(1..15))
@dish_28 = Dish.create(name: "Meadowlark Burger", restaurant_id: @restaurant_10.id, popularity: rand(1..15))
@dish_29 = Dish.create(name: "Smoked Brisket", restaurant_id: @restaurant_10.id, popularity: rand(1..15))

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

# Seed data using 'Faker' gem

# 5.times do
#   @user = User.create(
#     email: Faker::Internet.email,
#     name: Faker::Name.name,
#     password: Faker::Internet.password(min_length = 6, max_length = 20),
#   )
#   @list = List.create(user_id: @user.id)
# end

# 10.times do
#   @restaurant = Restaurant.create(
#     name: Faker::Food.spice,
#     cuisine: Faker::Address.country,
#     location: Faker::Address.city
#   )
#     rand(1..4).times do Dish.create(
#       name: Faker::Food.dish,
#       restaurant_id: @restaurant.id,
#       popularity: rand(1..10)
#     )
#     end
# end

# Create Demo user, with unique ListItems
# @demo_user = User.create(email: "john@example.com", name: "John Doe", password: "testing")
# @demo_list = List.create(user_id: @demo_user.id)
# dish_ids = Array.new(10) { rand(1...@dishes.count) }
# dish_ids.uniq.each do |id|
#   ListItem.create(
#     list_id: @demo_list.id,
#     dish_id: id,
#     tasted: [true, false].sample
#   )
# end
