require 'pry'

class ListsController < ApplicationController
  before_action :require_login, only: [:show]

  def index
    # if current_user
    #   @lists = current_user.lists
    # else
      @lists = List.all
    # end
  end

  def show
    @list = List.find_by(id: params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to list_path(@list), alert: "New list successfully created"
    else
      flash[:alert] = @list.errors.full_messages.first
      redirect_to new_list_path
    end
  end

  private
  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access that page"
      redirect_to new_user_registration_path
    end
  end

  def list_params
    params.require(:list).permit(:user_id)
  end
end
