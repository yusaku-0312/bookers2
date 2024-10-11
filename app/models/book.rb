class Book < ApplicationRecord
  
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  belongs_to :user
  
  validates :title, presence: true
  validates :body, length: { in: 1..200 }
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
