class AddressesController < Users::ApplicationController
  before_action :set_address, only: %i[show edit update]

  def new
    @address = current_user.create_address
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save!
      redirect_to address_path, notice: '新規追加しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @address.update(address_params)
      redirect_to address_path, notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_address
    @address = current_user.address
  end

  def address_params
    params.require(:address).permit(:address_name, :location)
  end
end
