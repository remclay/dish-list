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

// If ajax post request doesn't work, display error message
Dish.fail = function(error) {
  console.error("Error", error);
}

Dish.prototype.formatRestaurantDish = function() {
  var html = ''
  html += `<li><strong><a href="/dishes/${this.id}">${this.name}</a></strong> | Added to 1 Dish-List</li><br><br>`
  return html
}

// On document ready or turbolinks load
$( document ).on('ready turbolinks:load', function() {

  // Next dish button on dish show page
  $(".js-next").on("click", function(e) {
    e.preventDefault();
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;

    // fix this to ask for json not hard code json extension
    $.get("/dishes/" + nextId + ".json", function(data) {
      // basic check if there is another dish to display
      if (data === null) {
        alert("There are no more dishes to show.")
        $(".js-next").text('')
      } else {
        const dish = data
        const popularityHtml = `Added to ${dish.data.attributes.popularity} Dish-Lists`
        // To do: extract into prototype method
        $(".dishName").text(dish.data.attributes.name);
        $(".restaurantName").text(dish.included[0].attributes.name);
        $(".restaurantCuisine").text(dish.included[0].attributes.cuisine);
        $(".restaurantLocation").text(dish.included[0].attributes.location);
        // To do: add singular / plural html depending on popularity
        $("#popularity").text(popularityHtml)

        // // re-set the id to current id on 'next' link
        $(".js-next").attr("data-id", dish.data["id"]);
      };
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
     html += '<form id="new_restaurant_dish" class="new_dish" action="/dishes" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="m9YexmmDnmoWqV/o+AabTDZnFcW3kSVdANRyj1ihwb+RAmlMLR+cmQVVGvScFhSzwASz8MOlb6zMEzN1boTtTQ==">'
     html += '<label for="dish_name">Dish name: </label>'
     html += '<input type="text" name="dish[name]" id="dish_name">'
     html += `<input type="hidden" name="restaurant_id" id="restaurant_id" value="${restaurant}">`
     html += '  <input type="submit" name="commit" value="Create Dish" class="form-submit" data-disable-with="Create Dish">'
     html += '</form>'

    $("#new_dish_form").append(html)
    $("form#new_restaurant_dish").on("form-submit", function(e) {
      // formSubmit(e);
    })
  });
})

  // Submit new dish via ajax
  // $("form#new_restaurant_dish").on("form-submit", function(e) {
  function formSubmit(e) {
    debugger
    e.preventDefault();
    const $form = $(this)
    const action = $form.attr("action")
    const params = $form.serialize()
    debugger
    $.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "POST"
    })
    .done(Dish.success)
    .fail(Dish.fail)
  }
