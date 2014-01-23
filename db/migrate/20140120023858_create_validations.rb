class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.references :task, index: true
      t.references :order, index: true
      t.boolean :approval

      t.timestamps
    end
  end
end
