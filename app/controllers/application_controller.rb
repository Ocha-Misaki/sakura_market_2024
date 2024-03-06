class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    return unless user_signed_in?

    current_user.cart || current_user.create_cart!
  end
end
