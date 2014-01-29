class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @order_type = OrderType.find(params[:order_type_id])
    year = params[:year]
    month = params[:month]
    day = params[:day]    
    #URL: order_type/1/2014/01/25     FULL DATE
    
    if Date.valid_date? year.to_i, month.to_i, day.to_i
      start_date = Date.parse("#{day}.#{month}.#{year}")
      end_date = start_date + 1
      @date = start_date
      orders_by_date(start_date, end_date)
      render 'orders/day'

    elsif year.nil? && month.nil? && day.nil?
      start_date = Date.today
      end_date = start_date + 1
      @date = start_date
      orders_by_date(start_date, end_date)
      render 'orders/day'
    
    elsif month.nil? && day.nil?
      start_date = Date.parse("1.1.#{year}")
      end_date = start_date.end_of_year + 1
      @date = start_date
      orders_by_date(start_date, end_date)
      render 'orders/year'

    elsif day.nil?  
      start_date = Date.parse("1.#{month}.#{year}")
      end_date = start_date.end_of_month + 1
      @date = start_date
      orders_by_date(start_date, end_date)
      render 'orders/month'

    end  
  end

  def orders_by_date(start_date, end_date)
    @order_type.orders = Order.where(created_at: start_date..end_date)
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

  def only_year
    #Placeholder for later
  end

  def year_and_month
    #Placeholder for later
  end

  def full_date
    #Placeholder for
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
