class CreateUserConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_configs do |t|
      t.integer :user_id
      t.boolean :Si_Mn_iron_changed, default: false
      t.boolean :high_Si_Si_Mn_changed, default: false
      t.boolean :high_C_Mn_Fe_changed, default: false
      t.boolean :high_C_Cr_Fe_changed, default: false

      t.datetime :Si_Mn_iron_config_updated_at
      t.datetime :high_Si_Si_Mn_config_updated_at
      t.datetime :high_Si_Si_Mn_config_updated_at
      t.datetime :high_C_Cr_Fe_config_updated_at

      t.jsonb :Si_Mn_iron_config, default: {}
      t.jsonb :high_Si_Si_Mn_config, default: {}
      t.jsonb :high_C_Mn_Fe_config, default: {}
      t.jsonb :high_C_Cr_Fe_config, default: {}

      t.timestamps
    end
  end
end
