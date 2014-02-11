class OrdersController < ApplicationController
  before_action :set_order, only: [:create, :edit, :update, :destroy]

  def index
    @order_type = OrderType.find(params[:order_type_id])
    year = params[:year]
    month = params[:month]
    day = params[:day]    

    if Date.valid_date? year.to_i, month.to_i, day.to_i
      show_day(year, month, day)

    elsif year.nil? && month.nil? && day.nil?
      show_current_day      
      
    elsif month.nil? && day.nil?
      show_year(year)

    elsif day.nil?
      show_month(year, month)
    end
  end

  def pie_chart
    errors = @orders.breakdown
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Category')
    data_table.new_column('number', 'Number of Errors')
    data_table.add_rows(errors.count)

    name_cell = 0

    errors.each_pair do |key, value|
      data_table.set_cell(name_cell, 0, key)
      data_table.set_cell(name_cell, 1, errors[key].values.sum )
      name_cell = name_cell + 1
    end
    
    opts   = { :width => 600, :height => 400, 
      :title => 'Error Distribution by Category', :is3D => false }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)   
  end

  def show_current_day
    @date = Date.today.in_time_zone
		@orders = Order.date(@date..@date.end_of_day)
    render 'orders/day'
  end

  def new
    @order_type = OrderType.find(params[:order_type_id])
    @order = Order.new
    @order.validations.build
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

  def show_day(year,month,day)
    @date = Date.parse("#{day}.#{month}.#{year}").in_time_zone
    time_range = (@date..@date.end_of_day)
   	@orders = Order.date(time_range)
    render 'orders/day'
  end

  def show_month(year,month)
    @date = Date.parse("1.#{month}.#{year}")
    time_range = (@date..@date.end_of_month + 1)
    @orders = Order.date(time_range)
    pie_chart
    render 'orders/month'
  end

  def show_year(year)
    render 'orders/year'
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:order, :note, :order_type_id,
        validations_attributes: [:id, :approval, :order_id, :task_id])
    end
end
