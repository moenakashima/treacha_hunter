class Prefecture < ApplicationRecord
  
  has_many :users
  
  has_many :teas
  
end
