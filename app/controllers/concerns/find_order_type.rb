module FindType
  extend ActiveSupport::Concern
    private

    def set_order_type
    	@order_type = OrderType.find(params[:order_type_id])
    end