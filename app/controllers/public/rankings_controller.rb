class Public::RankingsController < ApplicationController
  
  def ranking
    # 投稿のいいね数ランキング
    @tea_favorite_ranking = Kaminari.paginate_array(Tea.find(Favorite.group(:tea_id).order('count(tea_id) desc').pluck(:tea_id))).page(params[:page])
  end
  
end

