require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @like = Like.new(user_id: 3, post_id: 1)
  end

  context 'When creating likes' do
    it 'Id of the user should be an integer' do
      @like.user_id = ''
      expect(@like).to_not be_valid
    end

    it 'Id of the post should be an integer' do
      @like.post_id = 'asdf'
      expect(@like).to_not be_valid
    end
  end

  it 'like counter to be 1' do
    user = User.create(name: 'test2')
    post = Post.create(title: 'Hello2', author: user)
    Like.create(user:, post:)
    expect(post.likes_counter).to eq(0)
  end
end
