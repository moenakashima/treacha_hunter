class Tea < ApplicationRecord

belongs_to :tea_type
belongs_to :prefecture
belongs_to :user

has_many :favorites
has_many :tea_comments
has_many :tea_tags

has_one_attached :tea_image

# 感想、商品名、お茶の種類にバリデーションを設定
validates :opinion, length: { maximum: 500 }
validates :product_name, presence: true
validates :tea_type, presence: true

# 投稿時に画像が設定されていない場合にデフォルト画像を表示させる
def get_tea_image(width, height)
  unless tea_image.attached?
  file_path = Rails.root.join('app/assets/images/default-image.jpg')
  tea_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
  end
  tea_image.variant(resize_to_limit: [width, height]).processed
end

end
