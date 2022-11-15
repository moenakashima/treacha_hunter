class Public::HomesController < ApplicationController
  
  before_action :authenticate_user!
  
  def top
    @teas = Tea.all

  end

end
