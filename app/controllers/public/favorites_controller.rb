class Public::FavoritesController < ApplicationController
  def create
    @tea = Tea.find(params[:tea_id])
    favorite = Favorite.new(user_id: current_user.id, tea_id: params[:tea_id])
    favorite.save
  end
  
  def destroy
    @tea = Tea.find(params[:tea_id])
    favorite = Favorite.find_by(user_id: current_user.id, tea_id: params[:tea_id])
    favorite.destroy
  end 

end