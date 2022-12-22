class Public::SearchesController < ApplicationController
  
  before_action :authenticate_user!
  
  def search
    #『#』が先頭に着いたら、タグで検索をする
    if (params[:keyword])[0] == '#'
      @taged_tea = Tag.search(params[:keyword])&.order('teas.created_at DESC')&.page(params[:page])
      if @taged_tea != nil
        @teas = @taged_tea.where(status: "published")
      end
      render "public/homes/top"
    # 未入力で検索したら、トップページをレンダー
    elsif params[:keyword] == ""
      render "public/homes/top"
    # それ以外の検索は投稿内容で検索
    else
      @teas = Tea.where(status: "published").search(params[:keyword])&.order('teas.created_at DESC')&.page(params[:page])
      render "public/homes/top"
    end
  end

end
