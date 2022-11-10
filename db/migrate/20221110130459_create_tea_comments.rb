class CreateTeaComments < ActiveRecord::Migration[6.1]
  def change
    create_table :tea_comments do |t|
      t.integer :tea_id, null: false
      t.integer :user_id, null: false
      t.string :comment, null: false
      t.timestamps
    end
  end
end
