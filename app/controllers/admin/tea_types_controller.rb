class Admin::TeaTypesController < ApplicationController
  
  before_action :authenticate_admin!
  
  def create
    @tea_type = TeaType.new(tea_type_params)
    if @tea_type.save
      redirect_to admin_tea_types_path
    else
      @tea_types = TeaType.all
      render :index
    end
  end

  def index
    @tea_types = TeaType.all
    @tea_type = TeaType.new
  end

  def edit
    @tea_type = TeaType.find(params[:id])

  end

  def update
    @tea_type = TeaType.find(params[:id])
    if @tea_type.update(tea_type_params)
      redirect_to admin_tea_types_path
    else
      render :edit
    end
  end

  def destroy
    @tea_type = TeaType.find(params[:id])
    @tea_type.destroy
    redirect_to request.referer
  end

  private
    def tea_type_params
      params.require(:tea_type).permit(:name)
    end
end
