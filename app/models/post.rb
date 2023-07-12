class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :comments

  validates :author_id, presence: true
  validates :title, presence: true
  validates :text, presence: true

  def post_counter
    update(posts_counter: posts.count)
  end
end
