class Post < ApplicationRecord
  acts_as_paranoid
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :board
  belongs_to :user
  has_many :comments
  has_many :favorite_posts
  has_many :favorite_users, through: :favorite_posts, source: "user"
  # 會做出一個favorite_users的方法，不是有一個model，source: :user
  # p1 = Post.find(1)
  # p1.favorite_users
  # p1.users
  
  validates :title, presence: true
  validates :content, presence: true

  def owned_by?(user)
    self.user == user
  end
  # 為何寫在model?
end
