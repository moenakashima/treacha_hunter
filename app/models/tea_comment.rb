class TeaComment < ApplicationRecord
  belongs_to :user
  belongs_to :tea, optional: true
  
  validates :comment, presence: true, length: {maximum: 60 }
end
