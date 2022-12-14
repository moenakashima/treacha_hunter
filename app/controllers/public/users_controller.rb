class Public::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :ensure_correct_user, only: [:update]
  
  def index
    @users = User.order('created_at DESC').page(params[:page])  
    @d1 = Date.today
  end

  def show
    @user = User.find(params[:id])
    @teas = @user.teas.where(status: "published").order('teas.created_at DESC').page(params[:page])
       
  # 参加して何日経ったのかを’ハンター歴’として表示するための日付計算       
    @d1 = Date.today
    @d2 = (@user.created_at).to_date
  # 今日の日付と参加日の差分を計算し文字列で取得    
    @hunter_histroy = (@d1 - @d2).to_i
    
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  # ユーザーのお気に入り（ブックマーク）のお茶を取得
  def favorite
    @user  = User.find(params[:user_id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    else
      favorite_teas = Favorite.where(user_id: current_user.id).order('favorites.created_at DESC').pluck(:tea_id)
      @favorite_tea_list = Kaminari.paginate_array(Tea.find(favorite_teas)).page(params[:page])
    end
    # 参加して何日経ったのかを’ハンター歴’として表示するための日付計算       
      @d1 = Date.today
      @d2 = (@user.created_at).to_date
    # 今日の日付と参加日の差分を計算し文字列で取得    
      @hunter_histroy = (@d1 - @d2).to_i
    
  end
  
  def sort_by_prefecture
    @d1 = Date.today
    @users = User.user_sort(params[:prefecture].reject(&:blank?)).page(params[:page]).order('created_at DESC')
    # 配列に空白がある場合は削除する
    @sorted_users = params[:prefecture].reject(&:blank?)
    
    render "public/users/index"
  end
  
  

  private

  def user_params
    params.require(:user).permit(:name,:email,:prefecture_id,:introduction, :profile_image)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
