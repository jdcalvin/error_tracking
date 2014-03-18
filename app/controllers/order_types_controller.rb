class OrderTypesController < ApplicationController
  before_action :set_order_type, only: [:show, :edit, :update]

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

    respond_to do |format|
      if @order_type.save
        format.html { redirect_to @order_type, 
          notice: 'Template was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @order_type.update(order_type_params)
        format.html { redirect_to @order_type, 
          notice: 'Template was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
		@order_type = OrderType.find(params[:id])
    @order_type.destroy
    respond_to do |format|
      format.html { redirect_to order_types_url }
    end
  end

  private
    def set_order_type
      @order_type = OrderType.load_associations(params[:id])
    end

    def order_type_params
      params.require(:order_type).permit(:title,
				categories_attributes: [:id, :name, :order_type_id, :_destroy,
				tasks_attributes: [:id, :description,
													 :category_id, :_destroy]])
    end
end
