class FoodsController < ApplicationController
  def index
    @foods = Food.custom_order
                 .displayable
                 .page(params[:page])
  end

  def show
    @food = Food.find(params[:id])
  end
end
