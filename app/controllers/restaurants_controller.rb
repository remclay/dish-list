class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find_by(id: params[:id])
  end

  def popular
    @restaurants = Dish.most_popular.collect {|dish| dish.restaurant }.uniq
  end
end
