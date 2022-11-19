class Public::SearchesController < ApplicationController
  def search
    if (params[:keyword])[0] == '#'
      @teas = Tag.search(params[:keyword])&.order('teas.created_at DESC')&.page(params[:page])
      render "public/homes/top"
    elsif params[:keyword] == ""
      render "public/homes/top"
    else
      @teas = Tea.search(params[:keyword])&.order('created_at DESC')&.page(params[:page])
      render "public/homes/top"
    end
  end

end
