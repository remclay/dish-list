// Show page, next button
$(function () {
  $(".js-next").on("click", function(e) {
    e.preventDefault();
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;

    $.get("/dishes/" + nextId + ".json", function(data) {
      const dish = data

      $(".dishName").text(dish["name"]);
      $(".restaurantName").text(dish["restaurant"]["name"]);
      $(".restaurantCuisine").text(dish["restaurant"]["cuisine"]);
      $(".restaurantLocation").text(dish["restaurant"]["location"]);
      // // re-set the id to current id on 'next' link
      $(".js-next").attr("data-id", data["id"]);
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
    });
    .done(function(json) {
      // append new dish to dom
      const html = `<li><strong><a href="/dishes/${json.data.id}">${json.data.attributes.name}</a></strong> | Added to 1 Dish-List</li><br><br>`
      $("#restaurant_show").append(html);
    });
    .fail(function(response) {
      // if ajax post request doesn't work
      // TO DO
      console.log("Broken", response);
    });
  });
});
