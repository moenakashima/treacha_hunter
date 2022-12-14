class Public::HomesController < ApplicationController
  
  before_action :authenticate_user!, except: [:about]
  
  def top
    @teas = Tea.where(status: "published").page(params[:page]).order('created_at DESC')

  end

end
