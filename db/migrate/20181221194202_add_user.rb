class AddUser < ActiveRecord::Migration[5.2]
  def self.up
    drop_table('users') if ActiveRecord::Base.connection.table_exists?('users')

    create_table :users do |t|
      t.boolean :is_admin, null: false, default: false
      t.string :name
      t.string :phone,           null: false, default: ""
      t.string :email,           null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.string :sex

      t.timestamps null: false
    end

    # add_index :users, :email,                unique: true
    # add_index :users, :phone,                unique: true
  end

  def self.down
    drop_table :users
  end
end
