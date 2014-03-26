class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :orders, :order, :order_name
  end
end
