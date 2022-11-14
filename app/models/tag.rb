class Tag < ApplicationRecord
  
  has_many :tea_tags, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持ち、それはtea_tagsを通じて参照できる
  has_many :teas, through: :tea_tags
  
  validates :name, uniqueness: true, presence: true
  
  def self.search(search)
    if search != '#'
      tag = Tag.find_by(name: search.delete('#'))
      tag && tag.teas
    else
      nil
    end
  end
end
