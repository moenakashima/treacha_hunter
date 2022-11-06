class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      
      # 都道府県名
      t.string :name, null: false

      t.timestamps
    end
  end
end
