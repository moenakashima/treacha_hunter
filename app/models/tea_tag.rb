class TeaTag < ApplicationRecord
  belongs_to :tea
  belongs_to :tag

  validates :tea_id, presence: true
  validates :tag_id, presence: true
end
