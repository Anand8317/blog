class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_comments_counter

  def self.update_comments_counter(post_id)
    Post.increment_counter(:comments_counter, post_id)
  end
end
