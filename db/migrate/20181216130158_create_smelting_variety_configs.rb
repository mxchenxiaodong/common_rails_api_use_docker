class CreateSmeltingVarietyConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :smelting_variety_configs do |t|
      t.string :name, comment: '硅锰合金、高硅硅锰、高碳锰铁、高碳铬铁等'
      t.string :en_name
      t.float :Mn_min, comment: 'Mn元素区间'
      t.float :Mn_max, comment: 'Mn元素区间'
      t.float :ternary_alkalinity_min, comment: '三元碱度区间'
      t.float :ternary_alkalinity_max, comment: '三元碱度区间'
      t.float :into_furnace_min, comment: '入炉品位'
      t.float :into_furnace_max, comment: '入炉品位'
      t.integer :mineral_num_min, comment: '矿种数量区间'
      t.integer :mineral_num_max, comment: '矿种数量区间'
      t.float :Si, comment: ''
      t.float :C, comment: ''
      t.float :P, comment: ''
      t.float :Mn_recovery_rate, comment: '锰回收率'
      t.float :Si_utilization_rate, comment: '硅利用率'
      t.float :silica_price, comment: '硅石价格'

      t.float :P_into_alloy, comment: 'P入合金'
      t.float :CaMg_into_furnace, comment: '钙镁入炉渣'
      t.float :Al_into_furnace, comment: '铝入炉渣'
      t.float :silica_content, comment: '硅石含量'

      t.timestamps
    end
  end
end
