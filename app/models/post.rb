class Post < ApplicationRecord
  belongs_to :artist
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :artist_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  
  private
    
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
