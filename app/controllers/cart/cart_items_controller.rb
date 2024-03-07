class Cart::CartItemsController < Users::ApplicationController
  before_action :set_cart_item, only: %i[update destroy]

  def create
    ## 後でリファクタする
    @cart_item = current_cart.cart_items.find_by(food_id: params[:food_id])
    if @cart_item
      @cart_item.increment(:quantity, params[:quantity].to_i)
      if @cart_item.save!
        redirect_to cart_path, notice: 'カート情報を更新しました'
      end
    else
      @cart_item = current_cart.cart_items.build(food_id: params[:food_id], quantity: params[:quantity].to_i)
      if @cart_item.save!
        redirect_to cart_path, notice: 'カートに追加しました'
      end
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cart_item.destroy!
    redirect_to cart_path, alert: '削除しました', status: :see_other
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
