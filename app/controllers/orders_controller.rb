class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order_type
  before_action :validate_user
  before_action :set_date, only: [:show_year, :show_month, :show_day]

  def index
    redirect_to order_type_show_day_path(
      @order_type, @today.year, @today.month, @today.in_time_zone.day)   
  end

  def show
    @user = @order.user
  end

  def new
    @order = @order_type.orders.build
  end

  def create
    @order = @order_type.orders.build(order_params)
    @order.user_id = current_user.id
    @order.error = @order.errors?
    if @order.save
      flash[:success] = "Order successfully created"
        redirect_to order_type_show_day_path(@order_type, 
        @order.date[2], @order.date[1], @order.date[0])
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update   
		if @order.update(order_params)
      @order.error = @order.errors?
      @order.save
			flash[:success] = "Order successfully updated"
			redirect_to order_type_show_day_path(@order_type, 
        @order.date[2], @order.date[1], @order.date[0])
		else
			render action: 'edit'
		end
  end

  def destroy
    @order.destroy
    flash[:danger] = "Order was successfully deleted"
    redirect_to order_type_orders_path
  end
  
  private

  def validate_user
    unless @order_type.organization == current_user.organization
      redirect_to root_url
      flash[:warning] = "You do not have permission to access that"
    end
  end
  
  def set_order
    @order = Order.find(params[:id])
  end

  def set_order_type
    @order_type = OrderType.find(params[:order_type_id])
  end

  def order_params
    params.require(:order)
		.permit(:order_name, :note, :order_type_id, :user_id, :error,
						:validations_attributes => [:id, :approval, :order_id, :task_id])
  end

end
