class RegionsController < ApplicationController
  before_action :check_admin!, only: [:create, :update, :destroy]
  before_action :set_region, only: [:show, :update, :destroy]

  def index
    say_happy(data: Region.all.order('weight_key desc'))
  end

  def show
    say_happy(data: @region)
  end

  def create
    begin
      @region = Region.create!(region_params)
      say_happy(data: @region)
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  def update
    begin
      @region.update!(region_params)
      say_happy(data: @region)
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  def destroy
    begin
      @region.destroy!
      say_happy
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  private
    def region_params
      params.permit(
        :city_name, :harbour, :electricity_fee, :freight, :weight_key
      )
    end

    def set_region
      @region = Region.find_by(id: params[:id])
    end
end
