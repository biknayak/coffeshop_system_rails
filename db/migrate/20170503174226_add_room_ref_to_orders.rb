class AddRoomRefToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :room_id, :integer
  end
end
