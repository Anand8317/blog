require 'rails_helper'

RSpec.feature "PostShow", type: :feature do
  let(:user) { User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') } 
  let!(:post) { Post.create!(author: user, title: 'Hello', text: 'This is my first post')}
  let!(:comment) {   Comment.create(post: post, user: user, text: 'Hi Tom!' )}

  before do
    visit user_post_path(user_id: user.id, id: post.id)
  end

  scenario "I can see the post's title" do
    expect(page).to have_content(post.title)
  end

  scenario "I can see who wrote the post" do
    expect(page).to have_content(user.name)
  end

  scenario "I can see how many comments it has" do
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  scenario "I can see how many likes it has" do
    expect(page).to have_content("Like: #{post.likes.count}")
  end

  scenario "I can see the post body" do
    expect(page).to have_content(post.text)
  end

  scenario "I can see the username of each commentor" do
    post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  scenario "I can see the comment each commentor left" do
    post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
  
end