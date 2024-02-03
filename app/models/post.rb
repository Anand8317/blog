class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  after_initialize :set_counters_to_zero

  def set_counters_to_zero
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5).includes(:user)
  end

  def update_posts_counter
    User.increment_counter(:post_counter, author.id)
  end
end
