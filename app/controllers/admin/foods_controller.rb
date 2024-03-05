class Admin::FoodsController < Admin::ApplicationController
  before_action :set_food, only: %i[show edit update move_higher move_lower destroy]

  def index
    @foods = Food.custom_order
                 .page(params[:page])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to admin_root_path, notice: '作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @food.update(food_params)
      redirect_to admin_food_path(@food), notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def move_higher
    @food.move_higher
    redirect_to admin_root_path, notice: '並び順を変更しました'
  end

  def move_lower
    @food.move_lower
    redirect_to admin_root_path, notice: '並び順を変更しました'
  end

  def destroy
    @food.destroy!
    redirect_to admin_root_path, alert: '削除しました', status: :see_other
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :displayable, :price, :description, :position)
  end
end
