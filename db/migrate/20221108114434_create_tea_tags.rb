class CreateTeaTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tea_tags do |t|
      t.references :tea, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグの保存を避ける
    add_index :tea_tags, [:tea_id, :tag_id], unique: true
  end
end
