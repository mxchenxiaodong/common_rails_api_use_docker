class CreateRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :regions do |t|
      t.string :city_name, comment: '城市名'
      t.string :harbour, comment: '港口'
      t.float :electricity_fee, comment: '电费'
      t.float :freight, comment: '运费'
      t.integer :weight_key, default: 1, comment: '权重值.值越大越靠前'
      t.timestamps
    end
  end
end
