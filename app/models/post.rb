class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  validates_associated :comments
  validates_associated :likes

  validates :author_id, presence: true
  validates :title, presence: true
  validates :title, length: { maximum: 255 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :text, presence: true

  after_save :posts_counter
  def posts_counter
    author.update(post_counter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
