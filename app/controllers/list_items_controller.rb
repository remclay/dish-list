class ListItemsController < ApplicationController

  def create
    # binding.pry
    if params[:list_id]
      target_list = current_user.list(params[:list_id])
      list_item = current_user.target_list.add_item
    else
      current_user.lists.first.add_item(params[:item_id])
    end
  end
end
