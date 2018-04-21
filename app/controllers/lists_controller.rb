class ListsController < ApplicationController
  before_action :authentication_required
  layout 'default'

  def index
    @lists = List.all
  end

  def show
    @list = List.find_by(id: params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:user_id)
  end
end
