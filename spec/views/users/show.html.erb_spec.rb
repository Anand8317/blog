require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  let(:user) { User.first }

  before do
    visit user_path(user)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'displays the username' do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content(user.posts.count)
  end

  it 'displays the user bio' do
    expect(page).to have_content(user.bio)
  end

  it 'displays the first 3 posts of the user' do
    user.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'has a button to view all posts of the user' do
    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  it 'redirects to post show page when a post is clicked' do
    post = user.posts.create!(title: 'Database', text: 'Test Database')
    visit user_path(user)
    click_on post.title
    expect(page).to have_current_path(user_post_path(user_id: user.id, id: post.id))
  end

  it 'redirects to user posts index page when view all posts button is clicked' do
    click_on 'See'
    expect(page).to have_current_path(user_posts_path(user), wait: 10)
  end
end
