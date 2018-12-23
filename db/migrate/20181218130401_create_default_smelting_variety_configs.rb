class CreateDefaultSmeltingVarietyConfigs < ActiveRecord::Migration[5.2]
  def change
    SmeltingVarietyConfig.create_default
  end
end
