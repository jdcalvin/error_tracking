class RemoveOrderTypeFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :order_type_id, :integer
  end
end
