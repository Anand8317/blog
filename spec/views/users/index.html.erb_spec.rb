require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  it 'displays usernames of all users' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays profile pictures of all users' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  it 'displays number of posts each user has written' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.posts.count)
    end
  end

  it 'redirects to user show page when a user is clicked' do
    visit users_path
    user = User.first
    click_on user.name
    expect(page).to have_current_path(user_path(user))
  end
end
