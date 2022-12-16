class Admin::UsersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def show
    @user = User.find(params[:id])
    @teas = @user.teas.where(status: "published").page(params[:page]).per(10).order('created_at DESC')
  end
  
  def edit
    @user = User.find(params[:id])
  
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @teas = @user.teas.page(params[:page]).per(10).order('created_at DESC')
    render :show
  
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:prefecture_id, :is_active)
  end
end
