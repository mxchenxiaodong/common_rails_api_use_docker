class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do |e|
    say_bad(msg: '查找不到记录', error: e.message)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    say_bad(msg: '记录不合法', error: e.message)
  end

  rescue_from Exception do |e|
    say_bad(error: e.message)
  end

  def authenticate_user!
    begin
      raise 'token过期，请重新登入' if !payload || !JsonWebToken.valid_payload(payload.first)
      raise 'token已被修改或登出，请重新登入' if token_changed?

      load_current_user!
      raise '用户不存在，请重新登入' unless @current_user
    rescue => e
      say_bad(status: :unauthorized, msg: e.message)
    end
  end

  def check_admin!
    unless current_user.is_admin?
      say_bad(msg: '没有权限')
    end
  end

  def say_happy(result = {})
    base_info = {
      code: 0,
      msg: '操作成功',
      data: []
    }
    render json: base_info.merge(result)
  end

  def say_bad(result = {})
    status = result.delete(:status)

    base_info = {
      code: 1,
      msg: '操作失败',
      error: ''
    }
    render json: base_info.merge(result), status: status
  end

  private
    def payload
      # token = params[:auth_token].to_s
      auth_header = request.headers['Authorization']
      token = auth_header.split(' ').last
      JsonWebToken.decode(token)
    rescue
      nil
    end

    def load_current_user!
      @current_user = User.find_by(id: payload[0]['user_id'])
    end

    def current_user
      @current_user
    end

    # 用来控制同一用户只有一个token有效
    # 用户token修改 或 退出，需要重新生成token
    def token_changed?
      user_id = payload[0]['user_id']

      new_created_at = $cache_client.get("user_token_#{user_id}")
      return true if new_created_at.blank?

      old_created_at = payload[0]['created_at']
      new_created_at != old_created_at
    end
end
