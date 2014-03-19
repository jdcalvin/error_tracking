class AddErrorToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :error, :boolean
  end
end
