class CreateTeaComments < ActiveRecord::Migration[6.1]
  def change
    create_table :tea_comments do |t|

      t.timestamps
    end
  end
end
