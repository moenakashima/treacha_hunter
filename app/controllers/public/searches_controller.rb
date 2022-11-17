class Public::SearchesController < ApplicationController
  def search
    if (params[:keyword])[0] == '#'
      @teas = Tag.search(params[:keyword])&.order('created_at DESC')&.page(params[:page])
    else
      @teas = Tea.search(params[:keyword])&.order('created_at DESC')&.page(params[:page])
    end
  end

end
