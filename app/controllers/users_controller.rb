class UsersController < ApplicationController

  def focus_minerals
    base_query = current_user.minerals

    # 港口/常用矿/类别
    [:harbour, :is_often, :category].each do |key|
      if params[key].present?
        base_query = base_query.where("minerals.#{key} = ? ", params[key])
      end
    end

    data = base_query.select("minerals.id, minerals.harbour, minerals.category, minerals.name, minerals.main_element, minerals.shelf_status")

    say_happy(data: data)
  end

  # 关注某种矿种
  def to_focus
    begin
      data = Mineral.find_or_create_by!(
        user_id: current_user.id,
        mineral_id: params[:mineral_id]
      )
      say_happy
    rescue Exception => e
      say_bad(error: e.message)
    end
  end
end
