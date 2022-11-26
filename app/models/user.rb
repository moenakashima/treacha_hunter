class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :prefecture

  has_one_attached :profile_image

  has_many :teas, dependent: :destroy
  
  # いいね機能
  has_many :favorites, dependent: :destroy
  # コメント機能
  has_many :tea_comments, dependent: :destroy

  # 名前、メールアドレス、都道府県、自己紹介にバリデーションを設定
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :email, presence: true
  validates :prefecture_id, presence: true
  validates :introduction, length: { maximum: 50 }
  
  # 画像の拡張子バリデーション追加
  validate :image_content_type, if: :was_attached?
  # 拡張子の確認を行う
  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/pjpeg', 'image/tiff', 'image/bmp', 'image/vnd.adobe.photoshop', 'image/vnd.microsoft.icon', 'image/webp']
    errors.add(:profile_image, "に利用できない拡張子が選択されています。jpg/jpeg/pngで投稿してください。") unless profile_image.content_type.in?(extension)
  end
  # 画像が添付されてない時は拡張子の確認をしない
  def was_attached?
    self.profile_image.attached?
  end
  
  
  
  # プロフィール画像が設定されていない場合にデフォルト画像を表示させる
  def get_profile_image(width, height)
    unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/default-image.jpg')
    profile_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # ゲストユーザーログイン用
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com', prefecture_id: 1 ) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

 # ユーザー地域絞り込み検索
  scope :user_sort, -> (sort_params) do
    return if sort_params.blank?
    prefecture_ids = []
    sort_params.each do |name|
    prefecture_ids << Prefecture.where(name: name).pluck(:id)
    end
    where(prefecture_id: prefecture_ids.flatten!)
  end

end
