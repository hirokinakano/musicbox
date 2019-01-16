class Artist < ApplicationRecord
  attr_accessor :remember_token
  has_many :posts, dependent: :destroy
  before_save { self.email = email.downcase }
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250},
                   format: {with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
  validates :content, length: {maximum: 500}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :image_size

  ## 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  ## ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  ## 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = Artist.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  ## 渡されたトークンがダイジェストと一致していたらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  ## モデルを降順に表示
  def feed
    Post.where("artist_id = ? ", id)
  end

  ## 検索用ロジック
  def self.search(search)
    #検索とnameの部分一致
    if search
      Artist.where(['name LIKE ?', "%#{search}%"])
    else
      Artist.all
    end
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_token, nil)
  end

  private

    #アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "画像のサイズを5MB以下にしてください")
      end
    end
end
