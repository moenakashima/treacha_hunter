class Public::TeaCommentsController < ApplicationController
  
  def create
    @tea = Tea.find(params[:tea_id])
    @tea_comment = current_user.tea_comments.new(comment_params)
    @tea_comment.tea_id = @tea.id
    @tea_comment.save
  end

  def destroy
    @tea = Tea.find(params[:tea_id])
    @tea_comment = TeaComment.find(params[:id])
    @tea_comment.destroy
  end


  private

  def comment_params
    params.require(:tea_comment).permit(:comment)
  end
end
