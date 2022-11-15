class Admin::TeaCommentsController < ApplicationController
  before_action :authenticate_amidn!
  
  def delete
    @tea = Tea.find(params[:tea_id])
    @tea_comment = TeaComment.find(params[:id])
    @tea_comment.destroy
  end
  
 
end
