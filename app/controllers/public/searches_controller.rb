class Public::SearchesController < ApplicationController
  def search
    if (params[:keyword])[0] == '#'
      @teas = Tag.search(params[:keyword])&.order('created_at DESC')
    else
      @teas = Tea.search(params[:keyword])&.order('created_at DESC')
    end
  end

end
