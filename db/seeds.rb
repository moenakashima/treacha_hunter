# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ログイン用データ.envに記載
Admin.create(email: ENV["SECRET_EMAIL"], password: ENV["SECRET_PASSWORD"])

# 都道府県データ追加用の記述
Prefecture.create(name: '不明')
Prefecture.create(name: '北海道')
Prefecture.create(name: '青森県')
Prefecture.create(name: '秋田県')
Prefecture.create(name: '岩手県')
Prefecture.create(name: '宮城県')
Prefecture.create(name: '山形県')
Prefecture.create(name: '福島県')
Prefecture.create(name: '栃木県')
Prefecture.create(name: '茨城県')
Prefecture.create(name: '群馬県')
Prefecture.create(name: '埼玉県')
Prefecture.create(name: '千葉県')
Prefecture.create(name: '東京都')
Prefecture.create(name: '神奈川県')
Prefecture.create(name: '新潟県')
Prefecture.create(name: '富山県')
Prefecture.create(name: '石川県')
Prefecture.create(name: '福井県')
Prefecture.create(name: '山梨県')
Prefecture.create(name: '長野県')
Prefecture.create(name: '岐阜県')
Prefecture.create(name: '静岡県')
Prefecture.create(name: '愛知県')
Prefecture.create(name: '三重県')
Prefecture.create(name: '滋賀県')
Prefecture.create(name: '京都府')
Prefecture.create(name: '大阪府')
Prefecture.create(name: '兵庫県')
Prefecture.create(name: '奈良県')
Prefecture.create(name: '和歌山県')
Prefecture.create(name: '鳥取県')
Prefecture.create(name: '島根県')
Prefecture.create(name: '岡山県')
Prefecture.create(name: '広島県')
Prefecture.create(name: '山口県')
Prefecture.create(name: '徳島県')
Prefecture.create(name: '香川県')
Prefecture.create(name: '愛媛県')
Prefecture.create(name: '高知県')
Prefecture.create(name: '福岡県')
Prefecture.create(name: '佐賀県')
Prefecture.create(name: '長崎県')
Prefecture.create(name: '熊本県')
Prefecture.create(name: '大分県')
Prefecture.create(name: '宮崎県')
Prefecture.create(name: '鹿児島県')
Prefecture.create(name: '沖縄県')


# # ジャンルのデータ追加
TeaType.create(name: '玉露')
TeaType.create(name: 'かぶせ煎茶')
TeaType.create(name: '煎茶')
TeaType.create(name: '深蒸し煎茶')
TeaType.create(name: '玉緑茶')
TeaType.create(name: '釜炒り茶')
TeaType.create(name: 'ほうじ茶')
TeaType.create(name: '玄米茶')
TeaType.create(name: '茎茶')
TeaType.create(name: '粉茶')
TeaType.create(name: '番茶')
TeaType.create(name: '抹茶')
TeaType.create(name: '碾茶')
TeaType.create(name: '和紅茶')
TeaType.create(name: '烏龍茶')
TeaType.create(name: '白茶')
TeaType.create(name: 'その他')

サンプルユーザー
User.create!(
  [
    {id: 1, name: 'トレチャー', email: 'user@test.example', password: 'password', prefecture_id: 21, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 2, name: 'りんか', email: 'treacha02@xxx.xxx', password: 'password', prefecture_id: 2, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 3, name: 'りんごま', email: 'treacha03@xxx.xxx', password: 'password', prefecture_id: 3, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 4, name: '大福', email: 'treacha04@xxx.xxx', password: 'password', prefecture_id: 4, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 5, name: 'トマト', email: 'treacha05@xxx.xxx', password: 'password', prefecture_id: 3, is_active: false, introduction: 'よろしくお願いします！' },
    {id: 6, name: '太郎', email: 'treacha06@xxx.xxx', password: 'password', prefecture_id: 6, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 7, name: '花子', email: 'treacha07@xxx.xxx', password: 'password', prefecture_id: 7, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 8, name: 'まめ子', email: 'treacha08@xxx.xxx', password: 'password', prefecture_id: 8, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 9, name: 'お茶大好き', email: 'treacha09@xxx.xxx', password: 'password', prefecture_id: 21, is_active: false, introduction: 'よろしくお願いします！' },
    {id: 10, name: 'せんちゃ', email: 'treacha10@xxx.xxx', password: 'password', prefecture_id: 10, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 11, name: '喫茶去', email: 'treacha11@xxx.xxx', password: 'password', prefecture_id: 11, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 12, name: 'ほうじちゃ', email: 'treacha12@xxx.xxx', password: 'password', prefecture_id: 12, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 13, name: 'てんちゃん', email: 'treacha13@xxx.xxx', password: 'password', prefecture_id: 13, is_active: false, introduction: 'よろしくお願いします！' },
    {id: 14, name: 'わこうちゃん', email: 'treacha14@xxx.xxx', password: 'password', prefecture_id: 15, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 15, name: 'トレチャン', email: 'treacha15@xxx.xxx', password: 'password', prefecture_id: 15, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 16, name: 'ティー', email: 'treacha16@xxx.xxx', password: 'password', prefecture_id: 16, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 17, name: 'カッパ', email: 'treacha17@xxx.xxx', password: 'password', prefecture_id: 15, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 18, name: 'れみ', email: 'treacha18@xxx.xxx', password: 'password', prefecture_id: 18, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 19, name: 'まるこ', email: 'treacha19@xxx.xxx', password: 'password', prefecture_id: 19, is_active: true, introduction: 'よろしくお願いします！' },
    {id: 20, name: 'momo', email: 'treacha20@xxx.xxx', password: 'password', prefecture_id: 21, is_active: true, introduction: 'よろしくお願いします！' },
  ]
)