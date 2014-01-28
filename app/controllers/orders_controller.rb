class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  def index
    date = Date.today-30
    @order_type = OrderType.find(params[:order_type_id])
    @date = Date.today

    if Date.valid_date? params[:year].to_i, params[:month].to_i, params[:day].to_i
      start_date = Date.parse("#{params[:day]}.#{params[:month]}.#{params[:year]}")
      end_date = start_date + 1

    elsif Date.valid_date? params[:year].to_i, params[:month].to_i, 1
      start_date = Date.parse("1.#{params[:month]}.#{params[:year]}")
      end_date = start_date.end_of_month

    elsif params[:year] && Date.valid_date?(params[:year].to_i, 1, 1)
      start_date = Date.parse("1.1.#{params[:year]}")
      end_date = start_date.end_of_year + 1
    end

    if start_date && end_date
      @order_type.orders = Order.where(created_at: start_date..end_date)
    else
      @orders = Order.all
    end
    
    #@order_by_date = @orders.group_by(&:created_at)

  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order_type = OrderType.find(params[:order_type_id])
    @order = Order.new
    @tasks = @order_type.tasks
      @order.validations.build
      task_id = @order.validations(params[:task_id])
  end

  def edit
  end

  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order = @order_type.orders.build(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_type_orders_path, notice: 'Order was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_type_orders_path, notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to order_type_orders_path,
        notice: 'Order has been removed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order, :note, :order_type_id,
        validations_attributes: [:id, :approval, :order_id, :task_id])
    end
end
