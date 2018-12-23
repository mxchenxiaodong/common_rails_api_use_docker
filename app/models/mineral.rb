class Mineral < ApplicationRecord

  validates :harbour, :category, :name, :price,
            :main_element, :granularity_min, :granularity_max,
            :granularity_rate, presence: true

  validate :check_category

  before_create :generate_seq_number
  after_save :keep_history_price

  scope :ofter, -> {
    where(is_ofter: true)
  }

  # 检查类型
  def check_category
    unless category.in?(['Mn', 'Cr'])
      raise '矿种类型不匹配'
    end
  end

  # 价格历史记录的保存
  def keep_history_price
    # 2014-01-23
    date = self.updated_at.strftime('%F')
    self.history_price[date] = self.price
  end

  # 获取历史价格，将当前的价格拼在最后.
  # 访问15个点
  def history_price_list
    today = Date.today.strftime('%F')
    list = self.history_price
    list[today] = self.price

    data = []
    list.keys.sort.reverse[0..14].each do |date|
      data.unshift([date, list[date]])
    end

    data
  end

  def generate_seq_number
    ActiveRecord::Base.transaction(requires_new: true) do
      @current_number = ActiveRecord::Base.connection.select_value("select nextval('minerals_number_seq')")
      self.no = "#{@current_number}".rjust(6, '0')
    end
  end
end
