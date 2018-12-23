class CreateMinerals < ActiveRecord::Migration[5.2]
  def change
    create_table :minerals do |t|
      t.string :harbour, comment: '港口'
      t.string :category, comment: '锰系（Mn）/铬系（Cr）'
      t.string :no, comment: '编号ID'
      t.string :name, comment: '名称'
      t.float :price, comment: '价格'
      t.float :main_element, comment: '主元素含量'
      t.float :granularity_min, comment: '最小粒度'
      t.float :granularity_max, comment: '最大粒度'
      t.float :granularity_rate, comment: '粒度占比'
      t.boolean :is_often, default:false, comment: '是否为常用矿'
      t.string :shelf_status, default: 'on', comment: '上架(on)/下架(off)'
      t.text :remark, comment: '备注'

      t.float :Fe
      t.float :SiO2
      t.float :Al2O3
      t.float :CaO
      t.float :MgO
      t.float :P
      t.float :water, comment: '水分'
      t.jsonb :history_price, default: {}, comment: '历史价格'
      t.timestamps
    end

    execute "CREATE SEQUENCE minerals_number_seq INCREMENT BY 1 START WITH 1"
  end
end
