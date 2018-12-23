class SmeltingVarietyConfig < ApplicationRecord
  validates :name, :en_name, :Mn_min, :Mn_max,
            :ternary_alkalinity_min, :ternary_alkalinity_max,
            :into_furnace_min, :into_furnace_max,
            :mineral_num_min, :mineral_num_max,
            :Mn_recovery_rate, :Si_utilization_rate,
            :silica_price, :P_into_alloy, :CaMg_into_furnace,
            :Al_into_furnace, :silica_content,
            presence: true

  class << self
    # SmeltingVarietyConfig.create_default
    def create_default
      four_names = {
        Si_Mn_iron: '硅锰合金',
        high_Si_Si_Mn: '高硅硅锰',
        high_C_Mn_Fe: '高碳锰铁',
        high_C_Cr_Fe: '高碳铬铁'
      }

      four_names.each do |en_name, name|
        config = SmeltingVarietyConfig.new(en_name: en_name, name: name)
        config.save(validate: false)
      end
    end
  end
end
