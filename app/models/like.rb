class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.update_likes_counter(post_id)
    Post.increment_counter(:likes_counter, post_id)
  end
end
