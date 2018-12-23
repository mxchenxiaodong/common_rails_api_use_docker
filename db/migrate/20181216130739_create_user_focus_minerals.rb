class CreateUserFocusMinerals < ActiveRecord::Migration[5.2]
  def change
    create_table :user_focus_minerals do |t|
      t.integer :user_id
      t.integer :mineral_id
      t.timestamps
    end

    add_index :user_focus_minerals, [:user_id, :mineral_id]
  end
end
