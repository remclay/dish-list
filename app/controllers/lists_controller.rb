class ListsController < ApplicationController
  before_action :authentication_required
  layout 'application'

  def index
    @lists = List.all
  end

  def show
    if params[:id].to_i == current_user.id
      redirect_to user_dishes_path(current_user)
    else
      @list = List.find_by(id: params[:id])
    end
  end

  private

  def list_params
    params.require(:list).permit(:user_id)
  end
end
