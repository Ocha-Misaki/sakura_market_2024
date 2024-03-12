class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def order_confirmation(order)
    @order = order
    mail(to: @order.user.email, subject: '【さくらマーケット】ご注文を受け付けました')
  end
end
