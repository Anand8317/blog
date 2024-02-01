class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Allow unconfirmed access for 7 days.
  # You can also set this to an integer specifying the number of days.
  # Or set this to false to require confirmation immediately.
  # Default is 0.days, meaning the user cannot access the website without confirming their email.
  Devise.setup do |config|
    config.allow_unconfirmed_access_for = 7.days
    config.reconfirmable = true
  end

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_post_counter_zero

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def set_post_counter_zero
    self.post_counter ||= 0
  end
end
