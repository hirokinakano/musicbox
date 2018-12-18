class Artist < ApplicationRecord
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
  
  def Artist.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def feed 
    Post.where("artist_id = ? ", id)  
  end
  
  def self.search(search) #ここでのself.はUser.を意味する
    if search
      Artist.where(['name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。
    else
      Artist.all #全て表示。User.は省略
    end
  end
  
  private
    
    #アップロードされた画像のサイズをバリデーションする
    def image_size 
      if image.size > 5.megabytes
        errors.add(:image, "画像のサイズを5MB以下にしてください")
      end
    end
end