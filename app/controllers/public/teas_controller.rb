class Public::TeasController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    @tea = Tea.new(tea_params)
    @tea.user_id = current_user.id
    
    # 登録ボタンを押した場合
    if params[:post]
      if @tea.save(context: :published)
        # 受け取った値を,で区切って配列にする
        @tag_list = params[:tea][:name].split(',')
        @tea.save_tag(@tag_list)
        redirect_to  confirm_tea_path(id: @tea.id)
      else
        @tag_list = params[:tea][:name]
        render :new
      end
    # 下書き保存ボタンを押した場合  
    else
      if @tea && @tea.save
        @tag_list = params[:tea][:name].split(',')
        @tea.save_tag(@tag_list)
        redirect_to draft_tea_path(current_user), notice: "投稿内容を下書き保存しました！"
      else
        render :new, alert: "下書き保存できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end
  
  def draft
    @user = User.find(params[:id])
    if current_user.id !=  @user.id
      redirect_to top_path
    end
    @teas = Kaminari.paginate_array(@user.teas.where(status: "draft").order('teas.updated_at DESC')).page(params[:page])
  end
  
  
  def new
    @tea = Tea.new
    if current_user.name == "guestuser"
      redirect_to top_path, notice: 'ゲストユーザーは閲覧のみ可能です' 
    end
  end

  def new_confirm
    @tea = Tea.find(params[:id])
    
    if @tea.user_id != current_user.id
      redirect_to top_path
    end
    
    @tag_list = @tea.tags.pluck(:name).join(',')
  end


  def confirm
    @tea = Tea.find(params[:id])
    
    if @tea.user_id != current_user.id
      redirect_to top_path
    end
    
    # APIを用いて自動タグ実装を追加
    @tags = Vision.get_image_data(@tea.tea_image)
    
    @tag_list = @tea.tags

  end

  def edit
    @tea = Tea.find(params[:id])

    if @tea.user_id != current_user.id
      redirect_to top_path
    end
    
    @tag_list = @tea.tags.pluck(:name).join(',')
  end

  def update
    @tea = Tea.find(params[:id])
    # path = Rails.application.routes.recognize_path(request.referer)
    #遷移元のURLで条件分岐を追加
    if params[:confirm]
      update_confirm
      redirect_to tea_path(@tea)
    elsif params[:post]
      update_new_confirm
    else
      update_edit
    end
    # if path[:controller] == "public/teas" && path[:action] == "confirm"
    #   update_confirm
    #   redirect_to tea_path(@tea)
    # elsif path[:controller] == "public/teas" && path[:action] == "new_confirm"
    #   update_new_confirm
    # else
    #   update_edit
    # end
  end

  def show
    @tea = Tea.find(params[:id])
    if @tea.status != "published"
      redirect_to top_path
    end
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
    @teas = @tag.teas.where(status: "published").order('teas.created_at DESC').page(params[:page])
    render "public/homes/top"
  end
  
  # お茶の種類絞り込み機能
  def search_tea_type
    @teas = Tea.where(status: "published").tea_search(params[:tea_type]).page(params[:page]).order('created_at DESC')
    # 配列に空白がある場合は削除する
    @search_teas = params[:tea_type].reject(&:blank?)
    
    render "public/homes/top"
  end


  private
  
  def tea_params
    params.require(:tea).permit(:product_name, :prefecture_id, :tea_image, :seller, :tea_type_id, :purchased_at, :opinion, :status)
  end
  
  def update_confirm
    @tea.update(tea_params)
    if params[:tags].present? && params[:tags].any?
      @tea.save_tag(params[:tags])
    end
  end
  
  def update_new_confirm
    # ①下書きを更新して登録する場合
    if params[:post]
      if @tea.update(tea_params) && @tea.valid?(:published)
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
        redirect_to confirm_tea_path(@tea)
      else
        @tag_list = @tea.tags.pluck(:name).join(',')
        render :new_confirm
      end
        
        
      # if @tea.save(context: :published)
      #   @tea.update(tea_params)
      #   tag_list = params[:tea][:name].split(',')
      #   # 重複したデータがある場合は一方を削除
      #   uniq_tag_list = tag_list.uniq
      #   # このtea_idに紐づいていたタグを@old_tagsに入れる
      #   @old_tags = TeaTag.where(tea_id: @tea.id)
      #   # それらを取り出し、消す。終わる
      #   @old_tags.each do |relation|
      #   relation.delete
      #   end
        
      #   @tea.save_tag(uniq_tag_list)
      #   redirect_to confirm_tea_path(@tea)
      # else
      #   @tag_list = @tea.tags.pluck(:name).join(',')
      #   render :new_confirm
      # end
     # ②下書きの更新（下書きのまま保存）の場合（バリデーションチェックは行わない）
    else
      @tea.update(tea_params)
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
      redirect_to draft_tea_path(@tea.user_id), notice: "下書きを更新しました！"
    end
  end
      
  def update_edit
    @tea.attributes = tea_params
    if @tea.save(context: :published)
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
      redirect_to tea_path(@tea), notice: "投稿を更新しました！"
    else
      @tag_list = @tea.tags.pluck(:name).join(',')
      render :edit
    end
  end
  
end
