class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order_type, only: [:new, :create, :index]
  before_action :validate_user
  
  def index
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

  def pie_chart_data(opt)
    arr = []
    opt.each_pair do |key, value|
      arr << [key, opt[key].values.sum]
    end
    return arr
  end

  def show_current_day
    @date = Date.today.in_time_zone
		@orders = @order_type.orders.date(@date..@date.end_of_day)
    @order_error_status = @orders.group_by(&:error)
    render 'orders/day'
  end

  def new
    @order = @order_type.orders.build
  end

  def edit
    @order_type = @order.order_type
  end

  def search
  end


  def create
    @order = @order_type.orders.build(order_params)
    @order.user_id = current_user.id
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
    redirect_to order_type_orders_path
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
    @errors = @orders.breakdown
    #pie_chart
    gon.chart_data = pie_chart_data(@errors)
    gon.date = @date.strftime("%B %Y")
    render 'orders/month'
    gon.clear

  end

  def show_year(year)
    render 'orders/year'
  end

  private

    def validate_user
      unless @order_type.organization == current_user.organization
        redirect_to root_url
        flash[:warning] = "You do not have permission to access that"
      end
    end
    
    def set_order_type
      @order_type = OrderType.find(params[:order_type_id])
    end
    def set_order
      @order = Order.find(params[:id])
      @order_type = OrderType.find(params[:order_type_id])
    end

    def order_params
      params.require(:order).permit(:order_name, :note, :order_type_id, :error, :user_id,
        validations_attributes: [:id, :approval, :order_id, :task_id])
    end
end
