class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json

  
  def index
    @order_type = OrderType.find(params[:order_type_id])
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order_type = OrderType.find(params[:order_type_id])
    @order = Order.new
      1.times { @order.validations.build }
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
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

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_type_orders_path, notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
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
        validations_attributes: [:id, :approval, :order_id])
    end
end
