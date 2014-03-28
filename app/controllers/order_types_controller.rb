class OrderTypesController < ApplicationController
  before_action :set_order_type, only: [:show, :edit, :update]
  before_action :validate_admin_status, 
    only: [:edit, :update, :destroy, :new, :create]

  def index
    @order_types = OrderType.all
  end

  def archive
    @order_type = OrderType.find(params[:order_type_id])
    @oldest_date = @order_type.orders.first.created_at.in_time_zone
    @current_date = Date.today.in_time_zone
  end

  def show
  end

  def new
		@order_type = OrderType.new
  end

  def edit
  end

  def create
    @order_type = OrderType.new(order_type_params)
    if @order_type.save
      flash[:success] = "Template created"
      redirect_to @order_type
    else
      render action: 'new'
    end
  end

  def update
    if @order_type.update(order_type_params)
      flash[:success] = "Template was successfully updated"
      redirect_to @order_type   
    else
      render action: 'edit'
    end
  end

  def destroy
		@order_type = OrderType.find(params[:id])
    @order_type.destroy
    flash[:danger] = "Template was deleted"
    redirect_to order_types_url
  end

  private

    def validate_admin_status
      unless current_user.admin
        redirect_to root_url
        flash[:warning] = "You must have adminstrative rights to access that."
      end
    end
    def set_order_type
      @order_type = OrderType.load_associations(params[:id])
    end

    def order_type_params
      params.require(:order_type).permit(:title, :organization_id,
				categories_attributes: [:id, :name, :order_type_id, :_destroy,
				tasks_attributes: [:id, :description,
													 :category_id, :_destroy]])
    end
end
