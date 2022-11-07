class Admin::TeaTypesController < ApplicationController

  def create
    @tea_type = TeaType.new
    @tea_type.save
    redirect_to request.referer

  end

  def index
    @tea_types = TeaType.all
  end

  def edit
    @tea_type = TeaType.find(params[:id])

  end

  def update
    @tea_type = TeaType.find(params[:id])
    @tea_type = TeaType.update
    redirect_to admin_tea_types_path
  end

  def destroy
    @tea_type = TeaType.find(params[:id])
    @tea_type.destroy
    redirect_to request.referer
  end

end
