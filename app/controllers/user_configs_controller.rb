class UserConfigsController < ApplicationController
  before_action :set_user_config

  def show
    say_happy(data: @user_config)
  end

  def update
    begin
      @user_config.update!(user_config_params)
      say_happy(@user_config)
    rescue Exception => e
      say_bad(error: e.message)
    end
  end

  private
    def user_config_params
      params.permit(
        :Si_Mn_iron_config, :high_Si_Si_Mn_config,
        :high_C_Mn_Fe_config, :high_C_Cr_Fe_config
      )
    end

    def set_user_config
      @user_config = current_user.user_config
    end
end
