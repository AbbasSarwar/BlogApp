class User < ApplicationRecord
  before_validation :set_default
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :likes, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  validates_associated :comments
  validates_associated :likes
  validates_associated :posts

  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, presence: true

  def recent_posts
    posts.order(created_at: :asc).limit(3)
  end

  def set_default
    self.name = email.split('@')[0]
    self.post_counter = 0
  end
end
