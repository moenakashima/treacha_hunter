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
  end

  def destroy
    @tea = Tea.find(params[:id])
    @tea.destroy
    redirect_to user_path(@tea.user)
  end

  # def ranking
  # end

  private
  def tea_params
    params.require(:tea).permit(:product_name, :prefecture_id, :tea_image, :seller, :tea_type_id, :parchased_at, :opinion)
  end
end
