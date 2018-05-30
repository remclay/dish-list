function Dish(attributes) {
  this.name = attributes.name
  this.id = attributes.id
  this.popularity = attributes.popularity
  this.restaurant_id = attributes.restaurant_id
}

// Create html to display new dish and append to dom
Dish.success = function(json) {
  const dish = new Dish({name: json.data.attributes.name, id: json.data.id, restaurant_id: json.data.attributes['restaurant-id'], popularity: 0})
  dishHtml = dish.formatRestaurantDish();
  $("#restaurant_show").append(dishHtml);
  // Need to also reset submit button
  $("form").trigger("reset");
}

// Display error message
Dish.fail = function(response) {
  // if ajax post request doesn't work
  // TO DO
  console.log("Broken", response);
}

Dish.prototype.formatRestaurantDish = function() {
  var html = ''
  html += `<li><strong><a href="/dishes/${this.id}">${this.name}</a></strong> | Added to 1 Dish-List</li><br><br>`
  return html
}

// On document ready
$(function () {
  // Next dish button on dish show page
  $(".js-next").on("click", function(e) {
    e.preventDefault();
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;

    // fix this to ask for json not hard code json extension
    $.get("/dishes/" + nextId + ".json", function(data) {
      const dish = data
      // refactor into prototype method
      $(".dishName").text(dish.data.attributes.name);
      $(".restaurantName").text(dish.included[0].attributes.name);
      $(".restaurantCuisine").text(dish.included[0].attributes.cuisine);
      $(".restaurantLocation").text(dish.included[0].attributes.location);
      // // re-set the id to current id on 'next' link
      $(".js-next").attr("data-id", dish.data["id"]);
    });
  });

  // Submit new dish via ajax
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
      // const html = `<li><strong><a href="/dishes/${json.data.id}">${json.data.attributes.name}</a></strong> | Added to 1 Dish-List</li><br><br>`
    .fail(Dish.fail)
  });
});
