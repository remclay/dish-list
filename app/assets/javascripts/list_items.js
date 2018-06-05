function ListItem(attributes) {
  this.id = attributes.id
  this.dish_id = attributes.dish_id
  this.dish_name = attributes.dish_name
  this.restaurant_name = attributes.restaurant_name
  this.restaurant_location = attributes.restaurant_location
}

ListItem.remove = function(response) {
  $("div#dish-id-"+response.data.attributes["dish-id"]).remove();
}

ListItem.fail = function(error) {
  // TO DO
  console.log("Broken", error)
}

ListItem.prototype.formatLI = function() {
  html = ''
  html += `<div class="inline">`
  html += `<a href="/dishes/${this.dish_id}">${this.dish_name}</a> | ${this.restaurant_name} | ${this.restaurant_location}`
  html += `</div><br>`
  return html
}

//   <form id="remove_list_item" class="button_to" method="post" action="/list_items/8">
//     <input type="hidden" name="_method" value="delete">
//     <input type="submit" value="remove">
//     <input type="hidden" name="authenticity_token" value="wVUuGhOYXQbIDIXHaUqCzqqw6ieLqOp5pUedftbED7XLgVmQVwRf9dvwwNsNWg0xXNNMEv+coIhpgNyE4OEjRw==">
//     <input type="hidden" name="dish_id" value="1">
//   </form>
// </div>

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
  // NEED TO PROPERLY RETREIVE THIS
  const list_id = window.location.pathname.slice(-1)
  $.ajax({
    url: "/list_items",
    type: "GET",
    data: {
      list: list_id
    }
  })
  .done(function(response) {
    response.data.forEach(function(li) {
      const list_item = new ListItem({id: li.id, dish_id: li.attributes["dish-id"], dish_name: li.attributes["dish-name"], restaurant_name: li.attributes["restaurant-name"], restaurant_location: li.attributes["restaurant-location"]})
      list_item_HTML = list_item.formatLI();
      $("#list_items").append(list_item_HTML)
    })
  })
  .fail(function(error) {
    console.log(error)
  })
})
