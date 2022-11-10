class Tea < ApplicationRecord

belongs_to :tea_type
belongs_to :prefecture
belongs_to :user

has_many :favorites
has_many :tea_comments

# 複数タグ投稿機能のリレーション
has_many :tea_tags, dependent: :destroy
has_many :tags, through: :tea_tags

# いいね機能
has_many :favorites, dependent: :destroy

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

#複数タグを保存するためのsaae_tagを定義
def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
  current_tags = self.tags.pluck(:name) unless self.tags.nil?
  # 現在取得したタグから送られてきたタグを除いてoldtagとする
  old_tags = current_tags - sent_tags
  # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
  new_tags = sent_tags - current_tags

  # 古いタグを消す
  old_tags.each do |old|
    self.tags.delete　Tag.find_by(name: old)
  end

  # 新しいタグを保存
  new_tags.each do |new|
    new_tea_tag = Tag.find_or_create_by(name: new)
    self.tags << new_tea_tag
 end
end

def self.search(search)
  if search != nil
    Tea.where('product_name LIKE(?) or opinion LIKE(?)' , "%#{search}%",  "%#{search}%")
  else
    Tea.all
  end
end

end
