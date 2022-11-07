class TeaType < ApplicationRecord

  # お茶の種類名のバリデーション
  validates :name, presence: true, uniqueness: true
end
