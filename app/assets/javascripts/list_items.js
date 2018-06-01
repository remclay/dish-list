function ListItem(attributes) {
  this.id = attributes.id
  this.list_id = attributes.list_id
  this.dish_id = attributes.dish_id
  this.tasted = attributes.tasted
}

ListItem.remove = function(response) {
  $("div#dish-id-"+response.data.attributes["dish-id"]).remove();
}

ListItem.fail = function(error) {
  // TO DO
  console.log("Broken", error)
}

// On document ready or turbolinks load
$( document ).on('ready turbolinks:load', function() {
  // Delete list item when remove clicked
  $("form#remove_list_item").on("submit", function(e) {
    e.preventDefault();
    const $form = $(this);
    const action = $form.attr("action")
    const params = $form.serialize()

    $.ajax({
      url: action,
      data: params,
      dataType: "json",
      method: "DELETE"
    })
    .done(ListItem.remove)
    .fail(ListItem.fail)
  });
// })

  // retrieve users list items
  const list_id = window.location.pathname.slice(-1)
  $.ajax({
    url: "/list_items",
    type: "GET",
    data: {
      list: list_id
    }
  })
  .done(function(response) {
    // debugger
    jQuery.each(response, function() {
    const list_item = new ListItem({id: json.data.attributes.name, list_id: json.data.id, dish_id: json.data.attributes['restaurant-id'], tasted: 0})
    list_item.formatLI();
  })

  })
  .fail(function(error) {
    console.log(error)
  })
})
