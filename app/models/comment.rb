class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true

  after_create :update_comments
  def update_comments
    post.update(comments_counter: post.comments.count)
  end
end
