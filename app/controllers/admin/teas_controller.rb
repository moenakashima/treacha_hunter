class Admin::TeasController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @teas = Tea.page(params[:page]).per(10).order('created_at DESC')
  end
  
  def show
    @tea = Tea.find(params[:id])
    @tea_tags = @tea.tags
    @user = @tea.user
    
    # 参加して何日経ったのかを’ハンター歴’として表示するための日付計算       
    @d1 = Date.today
    @d2 = (@user.created_at).to_date
    # 今日の日付と参加日の差分を計算し文字列で取得    
    @hunter_histroy = (@d1 - @d2).to_i
  end
end
