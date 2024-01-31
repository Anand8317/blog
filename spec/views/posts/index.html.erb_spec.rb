require 'rails_helper'

RSpec.feature "UserPostIndex", type: :feature do
  let(:user) { User.create!(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') } 
  let!(:post) { Post.create!(author: user, title: 'Hello', text: 'This is my first post')}
  let!(:comment) {   Comment.create(post: post, user: user, text: 'Hi Tom!' )}
  
  before do
    visit user_posts_path(user)
  end

  scenario "I can see the user's profile picture" do
    expect(page).to have_selector("#profile-pic")
  end

  scenario "I can see the user's username" do
    expect(page).to have_content(user.name)
  end

  scenario "I can see the number of posts the user has written" do
    expect(page).to have_content("Number of posts: #{user.posts.count}")
  end

  scenario "I can see a post's title" do
    expect(page).to have_content(user.posts.first.title)
  end

  scenario "I can see some of the post's body" do
    expect(page).to have_content(post.text) 
  end

  scenario "I can see the first comments on a post" do
    first_comment = post.comments.first
    expect(page).to have_content(comment.text)
  end

  scenario "I can see how many comments a post has" do
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  scenario "I can see how many likes a post has" do
    expect(page).to have_content("Like: #{post.likes.count}")
  end

  scenario "I can see a section for pagination if there are more posts than fit on the view" do
    
    visit user_posts_path(user)
    expect(page).to have_selector('.see-all-post-btn')
  end

  scenario "When I click on a post, it redirects me to that post's show page" do
    click_on post.title
    expect(page).to have_current_path(user_post_path(user_id: user.id, id: post.id))
  end
end