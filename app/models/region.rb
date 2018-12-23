class Region < ApplicationRecord
  # TianjinHarbour -> 天津港
  # QinzhouHarbour -> 钦州港
  HARBOUR = ['TianjinHarbour', 'QinzhouHarbour']

  validates :city_name, :harbour, :electricity_fee, :freight, presence: true

  validate :check_name

  scope :by_harbour, ->(harbour) {
    where(harbour: harbour)
  }

  def check_name
    if self.class.where(city_name: self.city_name).where.not(id: self.id).exists?
      raise '该地区名已经存在'
    end
  end

  class << self
    def all_regin
    end
  end
end
