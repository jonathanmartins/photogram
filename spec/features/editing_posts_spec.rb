require 'rails_helper'

feature 'Editing posts' do
  background do
    user = create :user
    user_two = create :user, email: 'hi@hi.com', username: 'BennyBoy'
    post = create :post, user_id: user.id
    post_two = create :post, user_id: user_two.id

    sign_in_with user
    visit '/'
  end

  scenario 'can edit a post as the owner' do
    find(:xpath, "//a[@href='posts/1']").click
    expect(page).to have_content 'Editar'

    click_link 'Editar'
    fill_in 'Add your caption', with: "Oh god why"
    click_button 'Update Post'

    expect(page).to have_content "Successfully updated!"
    expect(page).to have_content "Oh god why"
  end

  scenario "cannot edit a post that doesn't belongs to you via show page" do
    find(:xpath, "//a[contains(@href, 'posts/2')]").click
    expect(page).to_not have_content 'Editar'
  end

  scenario "cannot edit a post that doesn't belongs to you via url path" do
    visit "/posts/2/edit"
    expect(page.current_path).to eq root_path
    expect(page).to have_content "That post doesn't belong to you!"
  end

  scenario "a post won't update without an image" do
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
    click_link 'Editar'
    attach_file 'post[image]', 'spec/files/cat.zip'
    click_button 'Update Post'

    expect(page).to have_content "Your post couldn't be updated"
  end
end
