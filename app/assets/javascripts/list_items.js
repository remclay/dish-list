function ListItem(attributes) {
  this.id = attributes.id
  this.dishId = attributes.dishId
  this.dishName = attributes.dishName
  this.restaurantName = attributes.restaurantName
  this.restaurantLocation = attributes.restaurantLocation
}

ListItem.remove = function(response) {
  $("div#dish-id-"+response.data.attributes["dish-id"]).remove();
}

ListItem.fail = function(error) {
  console.error("Error", error)
}

ListItem.prototype.formatLI = function(index) {
  html = ''
  html += `<br><strong>${index + 1}. </strong>`
  html += `<a href="/dishes/${this.dishId}">${this.dishName}</a> | ${this.restaurantName} | ${this.restaurantLocation} <br>`
  return html
}

// On document ready or turbolinks load
$( document ).on('turbolinks:load', function() {
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
  $(".view_list").on("click", function(e) {
    e.preventDefault();
    const $link = $(this);
    const listId = $link[0].id

    $.ajax({
      url: "/list_items",
      type: "GET",
      data: {
        list: listId
      }
    })
    .done(function(response) {
      const listId = response.data[0].attributes["list-id"]
      let listItemHTML = `<div class="user-list-items"><br>`
      // order list items by restaurant name
      response.data.sort(function (a, b) {
        if (a.attributes["restaurant-name"] < b.attributes["restaurant-name"]) {
          return -1
        } if (a.attributes["restaurant-name"] > b.attributes["restaurant-name"]) {
          return 1
        } else {
          return 0
        }
      })
      response.data.forEach(function(li, index) {
        const listItem = new ListItem({id: li.id, dishId: li.attributes["dish-id"], dishName: li.attributes["dish-name"], restaurantName: li.attributes["restaurant-name"], restaurantLocation: li.attributes["restaurant-location"]})
        listItemHTML += listItem.formatLI(index);
      })
      listItemHTML += '</div><br>'
      $(`li#${listId}`).append(listItemHTML)
    })
    .fail(function(error) {
      console.error("Error", error)
    });
  });
})
