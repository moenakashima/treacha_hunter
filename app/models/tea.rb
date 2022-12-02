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
  
  # コメント機能(新着順に表示)
  has_many :tea_comments, -> { order(created_at: :desc) }, dependent: :destroy
  
  # google_apiのタグ
  has_many :api_tags, dependent: :destroy
  
  has_one_attached :tea_image
  
  # 投稿画像、感想、商品名にバリデーションを設定
  validates :opinion, length: { maximum: 500 }
  validates :product_name, presence: true
  validates :tea_image, presence: true
  
  # 画像の拡張子バリデーション追加
  validate :image_content_type, if: :was_attached?
  
  # 拡張子の確認を行う
  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/pjpeg', 'image/tiff', 'image/bmp', 'image/vnd.adobe.photoshop', 'image/vnd.microsoft.icon', 'image/webp']
    errors.add(:tea_image, "に利用できない拡張子が選択されています。jpg/jpeg/pngで投稿してください。") unless tea_image.content_type.in?(extension)
  end
  # 画像が添付されてない時は拡張子の確認をしない
  def was_attached?
    self.tea_image.attached?
  end
  
  # 画像のサイズ指定の可変化設定
  def get_tea_image(width, height)
    tea_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #複数タグを保存するためのsave_tagを定義
  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
  
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
  
    # 新しいタグを保存
    new_tags.each do |new|
      new_tea_tag = Tag.find_or_create_by(name: new)
      self.tags << new_tea_tag
   end
  end
  
  # 検索窓でのサーチアクションを定義（キーワード検索）
  def self.search(search)
    # nilでない限り、商品名、投稿文の曖昧検索と産地の前方一致検索を行う
    if search != nil
      Tea.joins(:prefecture).where('product_name LIKE(?) or opinion LIKE(?) or prefectures.name LIKE(?)' , "%#{search}%",  "%#{search}%", "#{search}%")
    else
      render "public/homes/top"
    end
  end
  
  # いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # お茶の種類絞り込み検索
  scope :tea_search, -> (search_params) do
    return if search_params.blank?
    tea_type_ids = []
    search_params.each do |name|
    tea_type_ids << TeaType.where(name: name).pluck(:id)
    end
    where(tea_type_id: tea_type_ids.flatten!)
  end

end
