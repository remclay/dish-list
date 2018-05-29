function ListItem(attributes) {
  this.id = attributes.id
  this.list_id = attributes.list_id
  this.dish_id = attributes.dish_id
  this.tasted = attributes.tasted
}

ListItem.remove = function(response) {
  $("div#dish-id-"+response.dish_id).remove();
}

ListItem.fail = function(error) {
  // TO DO
  console.log("Broken", error)
}

$(function () {
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
})
