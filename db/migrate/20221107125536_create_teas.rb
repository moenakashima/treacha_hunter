class CreateTeas < ActiveRecord::Migration[6.1]
  def change
    create_table :teas do |t|

      t.timestamps
    end
  end
end
