class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true

  def update_likes
    update(likes_counter: likes.count)
  end
end
