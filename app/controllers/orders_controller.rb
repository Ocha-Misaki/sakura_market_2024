class OrdersController < Users::ApplicationController
  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.new
    if @order.create_order_from_cart(current_cart)
      redirect_to root_path, notice: 'ご注文完了しました。メールをご確認ください。'
    else
      redirect_to cart_path, alert: '注文不可の商品がカートに入っていたため、注文完了できませんでした。'
    end
  end

  def show; end
end
