class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true

  def update_comments
    update(comments_counter: comments.count)
  end
end