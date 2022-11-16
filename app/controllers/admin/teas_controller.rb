class Admin::TeasController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @teas = Tea.page(params[:page]).order('created_at DESC')
  end
  
  def show
    @tea = Tea.find(params[:id])
    @tea_tags = @tea.tags
    @tea_comment = TeaComment.new
    @tea_comments = TeaComment.all.order('created_at DESC')
  end
end
