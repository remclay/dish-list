// Show page, next button
$(function () {
  $(".js-next").on("click", function(e) {
    e.preventDefault();
    var nextId = parseInt($(".js-next").attr("data-id")) + 1;

    $.get("/dishes/" + nextId + ".json", function(data) {
      const dish = data
      console.log(dish)

      $(".dishName").text(dish["name"]);
      $(".restaurantName").text(dish["restaurant"]["name"]);
      $(".restaurantCuisine").text(dish["restaurant"]["cuisine"]);
      $(".restaurantLocation").text(dish["restaurant"]["location"]);
      // // re-set the id to current id on 'next' link
      $(".js-next").attr("data-id", data["id"]);
    });
  });
});
