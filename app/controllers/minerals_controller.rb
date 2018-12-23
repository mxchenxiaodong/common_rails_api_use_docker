class MineralsController < ApplicationController
  before_action :check_admin!, only: [:create, :update, :destroy]
  before_action :set_mineral, only: [:show, :update, :destroy, :user_show]

  def index
    base_query = Mineral.all.order('updated_at desc')

    # 港口/常用矿/类别
    [:harbour, :is_often, :category].each do |key|
      if params[key].present?
        base_query = base_query.where("#{key} = ? ", params[key])
      end
    end

    say_happy(data: base_query)
  end

  def create
    begin
      @mineral = Mineral.create!(mineral_params)
      say_happy(data: @mineral)
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  def show
    data = @mineral.as_json(expect: [:history_price])
    say_happy(data: data)
  end

  def update
    begin
      @mineral.update!(mineral_params)
      say_happy
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  def destroy
    begin
      @mineral.destroy!
      say_happy
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  # ====== 下面是用户的接口 ======
  # 先从缓存读取
  def simple_count
    group_count = Mineral.group(:harbour).count
    data = {}

    Region::HARBOUR.each do |harbour|
      last_record = Mineral.where(harbour: harbour).order("updated_at desc").first
      last_updated_at = last_record.try(:updated_at)
      data[harbour] = {
        count: group_count[harbour],
        updated_at: last_updated_at
      }
    end

    say_happy(data: data)
  end

  def user_show
    data = @mineral.as_json(expect: [:history_price])

    # 历史价格
    data[:history_price] = @mineral.history_price_list

    # 是否已经关注
    data[:is_focus] = current_user.focused(params[:mineral_id])
    say_happy(data: data)
  end

  private
    def set_mineral
      @mineral = Mineral.find_by(id: params[:id])
    end

    def mineral_params
      params.permit(
        :harbour, :category, :name, :price, :main_element,
        :granularity_min, :granularity_max, :granularity_rate,
        :remark, :is_often, :shelf_status,
        :Fe, :SiO2, :Al2O3, :CaO, :MgO, :P, :water
      )
    end
end
