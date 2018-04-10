class ListsController < ApplicationController

  def index
    @lists = List.all
  end
  
  def show
    @list = List.find_by(id: params[:id])
  end
end
