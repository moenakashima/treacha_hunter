class Public::TeasController < ApplicationController

  def create
    @tea = Tea.new(tea_params)
    @tea.user_id = current_user.id

    # 受け取った値を,で区切って配列にする
    tag_list = params[:tea][:name].split(',')

    if @tea.save
      @tea.save_tag(tag_list)
      redirect_to root_path, notice: '投稿完了しました!'
    else
      render :new
    end
  end

  def new
    @tea = Tea.new
  end

  def edit
    @tea = Tea.find(params[:id])
    @tag_list = @tea.tags.pluck(:name).join(',')
  end

  def update
    @tea = Tea.find(params[:id])
    if @tea.update(tea_params)
      tag_list = params[:tea][:name].split(',')
      # このtea_idに紐づいていたタグを@oldに入れる
      @old_tags = TeaTag.where(tea_id: @tea.id)
      # それらを取り出し、消す。消し終わる
      @old_tags.each do |relation|
      relation.delete
      end

      @tea.save_tag(tag_list)
      redirect_to tea_path(@tea)
    else
      render :edit
    end
  end

  def show
    @tea = Tea.find(params[:id])
    @tea_tags = @tea.tags
    @tea_comment = TeaComment.new
    # @tea_comments = TeaComment.all.order('created_at DESC')
    # @tea_comments = TeaComment.page(params[:page])
  end

  def destroy
    @tea = Tea.find(params[:id])
    @tea.destroy
    redirect_to user_path(@tea.user)
  end
  
  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る 
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @teas = @tag.teas.order('created_at DESC')
  end
  
  def search_tea_type
      @teas = Tea.tea_search(params[:tea_type]).page(params[:page]).order('created_at DESC')
      # 配列に空白がある場合は削除する
      @search_teas = params[:tea_type].reject(&:blank?)
      
      render "public/homes/top"
  end

  # def ranking
  # end

  private
  def tea_params
    params.require(:tea).permit(:product_name, :prefecture_id, :tea_image, :seller, :tea_type_id, :parchased_at, :opinion)
  end
  

end
