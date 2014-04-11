class DatesController < ApplicationController
	before_filter :authenticate_user!
  before_action :set_order_type
  before_action :validate_user
  before_action :set_date, only: [:show_year, :show_month, :show_day]
  after_filter :clear_gon, only: [:show_month]

  def show_day
    time_range = (@date.beginning_of_day.in_time_zone..@date.end_of_day.in_time_zone)
    @orders = @order_type.orders.date(time_range)
    @order_error_status = @orders.group_by(&:error)
  end

  def show_month
    time_range = (@date.beginning_of_month.to_date..@date.end_of_month.to_date + 1)
    @orders = @order_type.orders.date(time_range)
    @orders_by_day = @orders.group_by {|x| x.created_at.day }
    @order_error_status = @orders.group_by(&:error)
    @errors = @orders.breakdown
    gon.chart_data = pie_chart_data(@errors)
    gon.date = @date.strftime("%B %Y")
  end

  def show_year
    redirect_to order_type_archive_path(@order_type.id)
  end

  def pie_chart_data(opt)
    arr = []
    opt.each_pair { |key, value| arr << [key, opt[key].values.sum] }
    return arr
  end

  def clear_gon
    gon.clear
  end

private

	def set_order_type
    @order_type = OrderType.find(params[:order_type_id])
  end
  
  def set_date
    if params[:year].nil? || params[:year].to_i == 0
      params[:year] = @today.year
      flash[:warning] = "Invalid date"
    elsif params[:month].to_i < 1 || params[:month].to_i > 12
      params[:month] = @today.month
        flash[:warning] = "Invalid date"
    end
    date = [params[:year], params[:month], params[:day]]
          .map {|p| p ||= '1' }
    if Date.valid_date? date[0].to_i, date[1].to_i, date[2].to_i
      @date = Date.parse("#{date[2]}.#{date[1]}.#{date[0]}")
    else
      @date = @today
      flash[:warning] = "Invalid date"
    end
  end

  def validate_user
    unless @order_type.organization == current_user.organization
      redirect_to root_url
      flash[:warning] = "You do not have permission to access that"
    end
  end


end

