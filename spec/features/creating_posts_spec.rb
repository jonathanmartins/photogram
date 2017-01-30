require 'rails_helper'

feature 'Creating posts' do
  background do
    user = create :user
    sign_in_with user
  end

  scenario 'can create a post' do
    visit '/'
    click_link 'New Post'
    fill_in 'Add your caption', with: 'Caption'
    attach_file 'post[image]', "spec/files/images/cat.jpg"
    click_button 'Create Post'

    expect(page).to have_content 'user'
    expect(page).to have_content 'Caption'
    expect(page).to have_css "img[src*='cat.jpg']"
  end

  scenario 'needs an image to create a post' do
    visit '/'
    click_link 'New Post'
    fill_in 'Add your caption', with: 'Caption'
    click_button 'Create Post'
    expect(page).to have_content "Your new post couldn't be created."
  end
end
