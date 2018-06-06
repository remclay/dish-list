function Dish(attributes) {
  this.name = attributes.name
  this.id = attributes.id
  this.popularity = attributes.popularity
  this.restaurant_id = attributes.restaurant_id
  this.restaurant_name = attributes.restaurant_name
  this.restaurant_cuisine = attributes.restaurant_cuisine
  this.restaurant_location = attributes.restaurant_location
}

// Create html to display new dish and append to dom
Dish.success = function(json) {
  const dish = new Dish({name: json.data.attributes.name, id: json.data.id, restaurant_id: json.data.attributes['restaurant-id'], popularity: 0})
  dishHtml = dish.formatRestaurantDish();
  $("#restaurant_show").append(dishHtml);
  // Remove form
  $("#new_dish_form").empty();
}

// If ajax post request doesn't work, display error message
Dish.fail = function(error) {
  console.error("Error", error);
}

Dish.prototype.formatRestaurantDish = function() {
  var html = ''
  html += `<li><strong><a href="/dishes/${this.id}">${this.name}</a></strong> | Added to 1 Dish-List</li><br><br>`
  return html
}

Dish.prototype.formatDishShow = function() {
  let html = ''
  html += `<h1>${this.name}</h1>`
  html += `<h3>at <a href="/restaurants/${this.restaurant_id}">${this.restaurant_name}</a></h3><br>`
  html += `<div class="inline"><p><strong>Type of cuisine: </strong>${this.restaurant_cuisine}</p></div><br>`
  html += `<div class="inline"><p><strong>Location:</strong>${this.restaurant_location}</p><br><br><br></div>`
  if(this.popularity === 1) {
    html += '<div>Added to 1 Dish-List</div>'
  } else {
    html += `<div>Added to ${this.popularity} Dish-Lists</div>`
  }
  return html
}

// On document ready or turbolinks load
$( document ).on('ready turbolinks:load', function() {

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
        const next_dish = new Dish({name: dish.data.attributes.name, restaurant_id: dish.data.attributes["restaurant-id"], restaurant_name: dish.included[0].attributes.name, restaurant_cuisine: dish.included[0].attributes.cuisine, restaurant_location: dish.included[0].attributes.location, popularity: dish.data.attributes.popularity})
        dishHtml = next_dish.formatDishShow();
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
     html = ''
     html += '<form id="new_restaurant_dish" class="new_dish" action="/dishes" accept-charset="UTF-8" method="post">'
     // html += '<input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="m9YexmmDnmoWqV/o+AabTDZnFcW3kSVdANRyj1ihwb+RAmlMLR+cmQVVGvScFhSzwASz8MOlb6zMEzN1boTtTQ==">'
     html += '<label for="dish_name">Dish name: </label>'
     html += '<input type="text" name="dish[name]" id="dish_name">'
     html += `<input type="hidden" name="restaurant_id" id="restaurant_id" value="${restaurant}">`
     html += '  <input type="submit" name="commit" value="Create Dish" class="form-submit" data-disable-with="Create Dish">'
     html += '</form><br>'

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
