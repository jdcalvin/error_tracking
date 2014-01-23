class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order
      t.string :note
      t.references :order_type, index: true

      t.timestamps
    end
  end
end
