class Public::HomesController < ApplicationController
  
  before_action :authenticate_user!, except: [:about]
  
  def top
    @teas = Tea.page(params[:page])

  end

end
