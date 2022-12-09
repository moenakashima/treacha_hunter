class Public::TeasController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    @tea = Tea.new(tea_params)
    @tea.user_id = current_user.id
    
    # 受け取った値を,で区切って配列にする
    @tag_list = params[:tea][:name].split(',')

    if @tea.save
      # APIを用いて自動タグ実装ここから
      # api_tags = Vision.get_image_data(@tea.tea_image)
      # api_tags.each do |api_tag|
      #   @tea.api_tags.create(name: api_tag)
      # end
      # APIを用いて自動タグ実装ここまで
      @tea.save_tag(@tag_list)
      redirect_to  teas_confirm_path(id: @tea.id)
    else
      render :new
    end
  end

  def new
    @tea = Tea.new
    if current_user.name == "guestuser"
      redirect_to top_path, notice: 'ゲストユーザーは閲覧のみ可能です' 
    end
  end

  def confirm
    @tea = Tea.find(params[:id])
    # APIを用いて自動タグ実装ここから
    @tags = Vision.get_image_data(@tea.tea_image)
    # APIを用いて自動タグ実装ここまで
    
    @tag_list = @tea.tags
  end

  def edit
    @tea = Tea.find(params[:id])
    @tag_list = @tea.tags.pluck(:name).join(',')
    if @tea.user_id != current_user.id
      redirect_to top_path
    end
  end

  def update

  path = Rails.application.routes.recognize_path(request.referer)
  
  @tea = Tea.find(params[:id])
  
    # path[:controller]で遷移元コントローラーを取得し、path[:action]でアクションを取得
    if path[:controller] == "public/teas" && path[:action] == "confirm"
    # if request.referer == teas_confirm_path
      # @old_tags = TeaTag.where(tea_id: @tea.id)
      # # それらを取り出し、消す。終わる
      # @old_tags.each do |relation|
      # relation.create
      # end 
      @tea.update(tea_params)
      # チェックボックスから送信されたデータを受け取る
      tags = params.select { |key, value| key.start_with?("tag") }
      
      # 特定の項目のみを取り出す
      selected_tags = tags.select { |key, value| value == "1" }
      selected_tags_array = selected_tags.keys
      @tea.save_tag(selected_tags_array)
      redirect_to tea_path(@tea)
    else
     
      if @tea.update(tea_params)
        tag_list = params[:tea][:name].split(',')
        # 重複したデータがある場合は一方を削除
        uniq_tag_list = tag_list.uniq
        # このtea_idに紐づいていたタグを@old_tagsに入れる
        @old_tags = TeaTag.where(tea_id: @tea.id)
        # それらを取り出し、消す。終わる
        @old_tags.each do |relation|
        relation.delete
        end
        
        @tea.save_tag(uniq_tag_list)
        redirect_to tea_path(@tea)
      else
        render :edit
      end
    end
    
  end

  def show
    @tea = Tea.find(params[:id])
    @tea_tags = @tea.tags
    @tea_comment = TeaComment.new
    @user = @tea.user
    
    # 参加して何日経ったのかを’ハンター歴’として表示するための日付計算       
    @d1 = Date.today
    @d2 = (@user.created_at).to_date
    # 今日の日付と参加日の差分を計算し文字列で取得    
    @hunter_histroy = (@d1 - @d2).to_i
  end

  def destroy
    @tea = Tea.find(params[:id])
    @tea.destroy
    redirect_to user_path(@tea.user)
  end
  
  # タグ検索機能
  def search_tag
    #検索されたタグを受け取る 
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @teas = @tag.teas.order('teas.created_at DESC').page(params[:page])
    render "public/homes/top"
  end
  
  # お茶の種類絞り込み機能
  def search_tea_type
    @teas = Tea.tea_search(params[:tea_type]).page(params[:page]).order('created_at DESC')
    # 配列に空白がある場合は削除する
    @search_teas = params[:tea_type].reject(&:blank?)
    
    render "public/homes/top"
  end


  private
  def tea_params
    params.require(:tea).permit(:product_name, :prefecture_id, :tea_image, :seller, :tea_type_id, :parchased_at, :opinion)
  end
  
end
