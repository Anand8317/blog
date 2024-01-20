class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def self.update_posts_counter(user_id)
    User.increment_counter(:post_counter, user_id)
  end
end
