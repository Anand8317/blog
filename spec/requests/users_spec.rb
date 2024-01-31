require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Users' do
    context 'Get index' do
      before(:each) do
        get '/users'
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'open the index template' do
        expect(response).to render_template(:index)
      end

      it 'shows that template includes correct placeholder text' do
        expect(response.body).to include('Number of posts:')
      end
    end

    context 'Get Show' do
      before(:each) do
        user = User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                            post_counter: 0)
        get "/users/#{user.id}"
      end

      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'open the show template' do
        expect(response).to render_template(:show)
      end

      it 'shows that template includes correct placeholder text' do
        expect(response.body).to include('Bio')
      end
    end
  end
end
