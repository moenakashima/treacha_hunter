class Public::TeasController < ApplicationController

  def create
    @tea = Tea.new(tea_params)
    @tea.user_id = current_user.id
    if @tea.save
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @tea = Tea.new
  end

  def edit
  end

  def update
  end

  def show
    @tea = Tea.find(params[:id])
  end

  def destroy
  end

  # def ranking
  # end

  private
  def tea_params
    params.require(:tea).permit(:product_name, :prefecture_id, :tea_image, :seller, :tea_type_id, :parchased_at, :opinion)
  end
end
