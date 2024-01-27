require 'rails_helper'

RSpec.describe 'Posts', type: :request do  
  describe 'GET index and show for posts' do
    context 'Get users/show/posts' do
      before(:each) do
        user = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', post_counter: 0)
        post = Post.create!(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        get "/users/#{user.id}/posts"
      end
      
      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'open the index template' do
        expect(response).to render_template(:index)
      end

      it 'shows that template includes correct placeholder text' do
        expect(response.body).to include('All the posts by specific user')
      end
    end

    context 'Get users/show/posts/show' do
      before(:each) do
        user = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', post_counter: 0)
        post = Post.create!(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
        get "/users/#{user.id}/posts/#{post.id}"
      end
      
      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'open the index template' do
        expect(response).to render_template(:show)
      end

      it 'shows that template includes correct placeholder text' do
        expect(response.body).to include('Specific post by specific user')
      end
    end



  end
end
