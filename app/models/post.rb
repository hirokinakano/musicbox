class Post < ApplicationRecord
  belongs_to :artist
  default_scope -> { order(created_at: :desc) }
  validates :artist_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
