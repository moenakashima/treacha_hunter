class Public::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def index
    @users = User.order('created_at DESC').page(params[:page])  
    @d1 = Date.today
  end

  def show
    @user = User.find(params[:id])
    @teas = @user.teas.page(params[:page]).order('created_at DESC')
       
  # 参加して何日経ったのかを’ハンター歴’として表示するための日付計算       
    @d1 = Date.today
    @d2 = (@user.created_at).to_date
  # 今日の日付と参加日の差分を計算し文字列で取得    
    @hunter_histroy = (@d1 - @d2).to_i
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def favorite
    @teas = Tea.order('created_at DESC').page(params[:page])
    
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:prefecture_id,:introduction, :profile_image)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
