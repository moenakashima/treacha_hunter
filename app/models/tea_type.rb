class TeaType < ApplicationRecord
  
  has_many :teas

  # お茶の種類名のバリデーション
  validates :name, presence: true, uniqueness: true
end
