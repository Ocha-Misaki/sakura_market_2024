# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview
  def order_confirmation
    OrderMailer.order_confirmation(Order.first)
  end
end
