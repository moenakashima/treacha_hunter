class Admin::HomesController < ApplicationController
 
  before_action :authenticate_admin!
  
  def top
    @users = User.page(params[:page]).per(10).order('created_at DESC')
  end  
end
