class SmeltingVarietyConfigsController < ApplicationController
  before_action :check_admin!, only: [:create, :update]
  before_action :set_config, only: [:show, :update]

  def index
    say_happy(data: SmeltingVarietyConfig.all)
  end

  def show
    say_happy(data: @config)
  end

  def show_by_en_name
    @config = SmeltingVarietyConfig.find_by(en_name: params[:en_name])
    say_happy(data: @config)
  end

  def create
    begin
      @config = SmeltingVarietyConfig.create!(config_params)
      say_happy(data: @config)
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  def update
    begin
      @config.update!(config_params)
      say_happy
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  private
    def config_params
      params.permit(
        :name, :Mn_min, :Mn_max,
        :ternary_alkalinity_min, :ternary_alkalinity_max,
        :into_furnace_min, :into_furnace_max,
        :mineral_num_min, :mineral_num_max,
        :Si, :C, :P, :Mn_recovery_rate, :Si_utilization_rate,
        :silica_price, :P_into_alloy, :CaMg_into_furnace,
        :Al_into_furnace, :silica_content
      )
    end

    def set_config
      @config = SmeltingVarietyConfig.find_by(id: params[:id])
    end
end
