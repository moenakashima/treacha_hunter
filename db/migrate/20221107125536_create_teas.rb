class CreateTeas < ActiveRecord::Migration[6.1]
  def change
    create_table :teas do |t|
      t.integer :tea_type_id, null: :false
      t.integer :user_id, null: :false
      t.integer :prefecture_id
      t.string :product_name, null: :false
      t.string :seller
      t.string :parchased_at
      t.text :opinion, null: :false
      t.timestamps
    end
  end
end
