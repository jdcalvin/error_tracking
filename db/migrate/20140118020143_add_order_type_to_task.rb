class AddOrderTypeToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :order_type, index: true, default: 1
  end
end
