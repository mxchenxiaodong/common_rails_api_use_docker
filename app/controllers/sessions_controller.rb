class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:create]

  def create
    @check_user = User.find_user(account: params[:account])

    if @check_user.blank? || !@check_user.authenticate(params[:password])
      say_bad(msg: '账号或密码错误')
      return
    end

    token_created_at = Time.now.to_s
    auth_token = JsonWebToken.encode({user_id: @check_user.id, created_at: token_created_at})

    # 用来控制同一用户只有一个token有效
    $cache_client.set("user_token_#{@check_user.id}", token_created_at)

    say_happy(
      msg: '登陆成功',
      data: {
        user: @check_user.as_json(except: User::IGNORE_ATTRIBUTES),
        jwt_auth: {
          auth_token: auth_token
        }
      }
    )
  end

  def destroy
    # 用来控制同一用户只有一个token有效
    $cache_client.del("user_token_#{current_user.id}") if current_user
    say_happy(msg: '登出成功')
  end
end
