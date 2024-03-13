class OrdersController < Users::ApplicationController
  def index
    @orders = current_user.orders.default_order.page(params[:page])
  end

  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.shipping_fee = current_cart.shipping_fee
    @order.cash_on_delivery_fee = current_cart.cash_on_delivery_fee
    @order.create_order_from_cart(current_cart)
    if @order.save!
      OrderMailer.order_confirmation(@order).deliver_later
      redirect_to root_path, notice: 'ご注文完了しました。メールをご確認ください。'
    else
      redirect_to cart_path, alert: '注文不可の商品がカートに入っていたため、注文完了できませんでした。'
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:order_name, :order_address, :delivery_time, :delivery_on)
  end
end
