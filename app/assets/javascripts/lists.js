// $(document).on('turbolinks:load', function() {
//   $.get('/list_items', function(data) {
//     debugger
//     $("#list_items").text(data)
//   })
// })
//
// function List(attributes) {
//   this.id = attributes.id
//   this.user_id = attributes.user_id
// }
//
// List.success = function(json) {
//   debugger
//   // const list = new List({id: , user_id:})
//   jQuery.each(arr, function() {
//     debugger
//     const list_item = new ListItem({id: json.data.attributes.name, list_id: json.data.id, dish_id: json.data.attributes['restaurant-id'], tasted: 0})
//     list_item.formatLI();
//   })
//

  // dishHtml = dish.formatRestaurantDish();
  // $("#restaurant_show").append(dishHtml);
// }

//
// $(function() {
//   const list_id = window.location.pathname.slice(-1)
//   $.ajax({
//     url: "/list_items",
//     type: "GET",
//     data: {
//       list: list_id
//     }
//   })
//   .done(List.success)
//   .fail(function(error) {
//     console.log(error)
//   })
// })







// $(function() {
//   $("a.view_list").on("click", function(e) {
//     e.preventDefault();
//     const $form = $(this)
//     const url = $form.href
//
//     $.get(url, function(data) {
//       // debugger
//     })
//   })
// })
