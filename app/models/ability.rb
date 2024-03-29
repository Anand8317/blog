class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    else
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
      can :read, Post
      can :create, Post, user_id: user.id
      can :create, Comment

      can :read, Comment
      can :create, Comment do |_comment|
        user.persisted?
      end
    end
  end
end
