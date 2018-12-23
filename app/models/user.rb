class User < ApplicationRecord

  IGNORE_ATTRIBUTES = [:created_at, :updated_at, :password_digest, :is_admin]

  has_secure_password

  has_many :user_focus_minerals
  has_many :minerals, through: :user_focus_minerals

  def focused(mineral_id)
    user_focus_minerals.exists?(mineral_id: mineral_id)
  end

  class << self
    def find_user(conditions={})
      where("name = ? or phone = ? or email = ?", *([conditions[:account]] * 3)).first
    end
  end
end
