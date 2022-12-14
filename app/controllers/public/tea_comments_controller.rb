class Public::TeaCommentsController < ApplicationController
  
  before_action :authenticate_user!, only:[:create]
  
  def create
    @tea = Tea.find(params[:tea_id])
    @tea_comment = current_user.tea_comments.new(comment_params)
    @tea_comment.tea_id = @tea.id
    @tea_comment.save
  end

  def destroy
    @tea = Tea.find(params[:tea_id])
    @tea_comment = TeaComment.find(params[:id])
    if @tea_comment.user == current_user || admin_signed_in?
    @tea_comment.destroy
    end  
  end
  
  private

  def comment_params
    params.require(:tea_comment).permit(:comment)
  end
end
