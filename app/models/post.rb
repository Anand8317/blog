class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def self.update_posts_counter(user_id)
    User.increment_counter(:post_counter, user_id)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
