class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order_type
  before_action :validate_user
  before_action :set_date, only: [:index,:show_year, :show_month, :show_day]

#=============================NAVIGATION=======================================

  def index
    redirect_to order_type_show_day_path(
      @order_type, @date.year, @date.month, @date.day)   
  end

  def show_day
    time_range = (@date..@date.end_of_day)
    @orders = @order_type.orders.date(time_range)
    @order_error_status = @orders.group_by(&:error)
    render 'orders/day'
  end

  def show_month
    time_range = (@date.beginning_of_month..@date.end_of_month)
    @orders = @order_type.orders.date(time_range)
    @orders_by_day = @orders.group_by {|x| x.created_at.day }
    @order_error_status = @orders.group_by(&:error)
    @errors = @orders.breakdown

    gon.chart_data = pie_chart_data(@errors)
    gon.date = @date.strftime("%B %Y")
    render 'orders/month'
    gon.clear
  end

  def show_year
    redirect_to order_type_archive_path(@order_type.id)
  end


  #=============================CRUD===========================================

  def show
    @user = @order.user
  end

  def new
    @order = @order_type.orders.build
  end

  def create
    @order = @order_type.orders.build(order_params)
    @order.user_id = current_user.id
    if @order.save
      @order.errors?
      flash[:success] = "Order successfully created"
      redirect_to order_type_orders_path
    else
      render action: 'new'
    end
  end

  def edit
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

  #=============================PRIVATE=======================================
  private

    def set_date
      if params[:year].nil? && params[:month].nil? && params[:day].nil?
        @date = Date.today.in_time_zone
      else
        date = [params[:year], params[:month], params[:day]]
              .map {|p| p ||= '1' }
        if Date.valid_date? date[0].to_i, date[1].to_i, date[2].to_i
          @date = Date.parse("#{date[2]}.#{date[1]}.#{date[0]}").in_time_zone
        else
          @date = Date.today.in_time_zone
        end
      end
    end

    def pie_chart_data(opt)
      arr = []
      opt.each_pair do |key, value|
        arr << [key, opt[key].values.sum]
      end
      return arr
    end

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
      params.require(:order).permit(:order_name, :note, :order_type_id, :error, :user_id,
        validations_attributes: [:id, :approval, :order_id, :task_id])
    end
end
