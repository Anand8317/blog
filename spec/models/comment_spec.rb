require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    user = User.create(name: 'Htet')
    post = Post.create(title: 'Hello', author: user)
    @comment = Comment.create(user:, post:, text: 'This is comment')
  end

  it 'Id of the post should be an integer' do
    @comment.post_id = 'asdf'
    expect(@comment).to_not be_valid
  end

  it 'Comment counter to be 1' do
    user = User.create(name: 'test1')
    post = Post.create(title: 'Hello', author: user)
    Comment.create(user:, post:, text: 'This is test comment')
    expect(post.comments_counter).to eq(0)
  end
end
