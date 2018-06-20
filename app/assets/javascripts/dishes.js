function Dish(attributes) {
  this.name = attributes.name
  this.id = attributes.id
  this.popularity = attributes.popularity
  this.restaurantId = attributes.restaurantId
  this.restaurantName = attributes.restaurantName
  this.restaurantCuisine = attributes.restaurantCuisine
  this.restaurantLocation = attributes.restaurantLocation
}

// Create html to display new dish and append to dom
Dish.success = function(json) {
  const dish = new Dish({name: json.data.attributes.name, id: json.data.id, restaurantId: json.data.attributes['restaurant-id'], popularity: 0})
  const dishHtml = dish.formatRestaurantDish();
  $("#restaurant_show").append(dishHtml);
  // Remove form
  $("#new_dish_form").empty();
}

// If ajax post request doesn't work, display error message
Dish.fail = function(error) {
  console.error("Error", error);
}

Dish.prototype.formatRestaurantDish = function() {
  return `<li><strong><a href="/dishes/${this.id}">${this.name}</a></strong> | Added to 1 Dish-List</li><br><br>`
}

Dish.prototype.formatDishShow = function() {
  let html = `
    <h1>${this.name}</h1>
    <h3>at <a href="/restaurants/${this.restaurantId}">${this.restaurantName}</a></h3><br>
    <div class="inline"><p><strong>Type of cuisine: </strong>${this.restaurantCuisine}</p></div><br>
    <div class="inline"><p><strong>Location:</strong>${this.restaurantLocation}</p><br><br><br></div>
  `
  html += (this.popularity === 1) ? '<div>Added to 1 Dish-List</div>' : `<div>Added to ${this.popularity} Dish-Lists</div>`
  return html
}

// On document ready or turbolinks load
$( document ).on('turbolinks:load', function() {

  // Next dish button on dish show page
  $(".js-next").on("click", function(e) {
    e.preventDefault();
    let dishIndexes
    let nextIndex

    $.get("/dishes.json", function(response) {
      dishIndexes = response.data.map(dish => parseInt(dish.id))
    })
    .done(function() {
      let currentId = parseInt($(".js-next").attr("data-id"))
      let currentIndex = dishIndexes.indexOf(currentId)
      // If reached last dish, start at beginning
      if(currentIndex === (dishIndexes.length -1)){
        nextIndex = 0
      } else {
        nextIndex = currentIndex + 1
      }
      let nextId = dishIndexes[nextIndex]

    $.get("/dishes/" + nextId + ".json", function(data) {

        const dish = data
        const nextDish = new Dish({name: dish.data.attributes.name, restaurantId: dish.data.attributes["restaurant-id"], restaurantName: dish.included[0].attributes.name, restaurantCuisine: dish.included[0].attributes.cuisine, restaurantLocation: dish.included[0].attributes.location, popularity: dish.data.attributes.popularity})
        dishHtml = nextDish.formatDishShow();
        $(".dish-show").html(dishHtml);
        // // re-set the id on 'next dish' link to current id
        $(".js-next").attr("data-id", dish.data["id"]);
      })
    });
  });

  // Get new dish form
  $("#button").on("click", function(e) {
     e.preventDefault();
     const $button = $(this);
     const restaurant = $(this).data("restaurant-id");
     const user = $(this).data("user")
     // to do add authenticity_token
     const html = `
        <form id="new_restaurant_dish" class="new_dish" action="/dishes" accept-charset="UTF-8" method="post">
          <label for="dish_name">Dish name: </label>
          <input type="text" name="dish[name]" id="dish_name">
          <input type="hidden" name="restaurant_id" id="restaurant_id" value="${restaurant}">
          <input type="submit" name="commit" value="Create Dish" class="form-submit" data-disable-with="Create Dish">
        </form><br>
      `
    $("#new_dish_form").append(html);

    // Create new dish via ajax post request
    $("form#new_restaurant_dish").on("submit", function(e) {
      e.preventDefault();
      const $form = $(this)
      const action = $form.attr("action")
      const params = $form.serialize()

      $.ajax({
        url: action,
        data: params,
        dataType: "json",
        method: "POST"
      })
      .done(Dish.success)
      .fail(Dish.fail)
    });
  });
});
