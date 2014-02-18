class AddOrderTypeRefToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :order_type, index: true
  end
end
