class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total, default: 0
      t.integer :user_id
      t.string :name
      t.integer :cellphone
      t.string :address
      t.timestamps
    end
  end
end
