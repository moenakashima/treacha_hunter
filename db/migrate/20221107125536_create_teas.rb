class CreateTeas < ActiveRecord::Migration[6.1]
  def change
    create_table :teas do |t|
      t.integer :tea_type_id, null: false
      t.integer :user_id, null: false
      t.integer :prefecture_id, null: false
      t.string :product_name
      t.string :seller
      t.string :purchased_at
      t.text :opinion, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
