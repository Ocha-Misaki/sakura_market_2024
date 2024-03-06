class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.default_order.page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, alert: '削除しました', status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
