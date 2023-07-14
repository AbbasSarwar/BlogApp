class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true

  after_create :update_likes_counter

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
