class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

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

  def show
  end

	def search
		@orders = Order.search(params[:search])
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
    
    opts   = { :width => 400, :height => 400, 
      :title => 'Error Distribution by Category', :is3D => false }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)   
  end

  def show_current_day
    @date = Date.today.in_time_zone
		@orders = @order_type.orders.date(@date..@date.end_of_day)
    @order_error_status = @orders.group_by(&:error)
    render 'orders/day'
  end

  def new
    @order_type = OrderType.load_associations(params[:order_type_id])
    @order = @order_type.orders.build
  end

  def edit
    @order_type = @order.order_type
  end

  def create
    @order_type = OrderType.find(params[:order_type_id])
    @order = @order_type.orders.build(order_params)
			if @order.save
        if @order.errors?
          @order.update_attributes(error: true)
        else
          @order.update_attributes(error:false)
        end
        flash[:success] = "Order successfully created"
        redirect_to order_type_orders_path
      else
        render action: 'new'
      end
  end

  def update
      if @order.update(order_params)
        flash[:success] = "Order successfully updated"
        redirect_to order_type_orders_path
      else
        render action: 'edit'
      end
  end

  def destroy
    @order.destroy
      flash[:danger] = "Order was successfully deleted"
      format.html { redirect_to order_type_orders_path,
        notice: 'Order has been removed.' }
  end

  def show_day(year,month,day)
    @date = Date.parse("#{day}.#{month}.#{year}").in_time_zone
    time_range = (@date..@date.end_of_day)
   	@orders = @order_type.orders.date(time_range)
    @order_error_status = @orders.group_by(&:error)
    render 'orders/day'
  end

  def show_month(year,month)
    @date = Date.parse("1.#{month}.#{year}")
    time_range = (@date..@date.end_of_month + 1)
		@orders = @order_type.orders.date(time_range)
    @orders_by_day = @orders.group_by {|x| x.created_at.day }
    @order_error_status = @orders.group_by(&:error)

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
      params.require(:order).permit(:order, :note, :order_type_id, :error,
        validations_attributes: [:id, :approval, :order_id, :task_id])
    end
end
