class AddOrganizationToOrderTypes < ActiveRecord::Migration
  def change
    add_reference :order_types, :organization, index: true
  end
end
