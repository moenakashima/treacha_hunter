class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    render :show
  
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:prefecture_id, :is_active)
  end
end
