class TeaComment < ApplicationRecord
  belongs_to :user
  belongs_to :tea
  
  validates :comment, presence: true, length: {maximum: 60 }
end
