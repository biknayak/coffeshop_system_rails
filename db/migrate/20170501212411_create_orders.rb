class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :note
      t.string :status
      t.string :total_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
