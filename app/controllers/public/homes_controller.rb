class Public::HomesController < ApplicationController
  
  def top
    @teas = Tea.all
  end

end
