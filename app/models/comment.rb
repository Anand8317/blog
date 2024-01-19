class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.update_comments_counter(post_id)
    Post.increment_counter(:comments_counter, post_id)
  end
end
