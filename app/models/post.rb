class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments

  validates :author_id, presence: true
  validates :title, presence: true
  validates :text, presence: true

  def post_counter
    self.update(posts_counter: self.posts.count)
  end
end
