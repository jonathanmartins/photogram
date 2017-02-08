require 'rails_helper'

feature 'editing user profiles' do
  background do
    user = create :user
    user_two = create :user, email: "email2@email.com", username: 'usuario'
    post = create :post, user_id: user.id
    post_two = create :post, user_id: user_two.id, caption: 'another caption'
    sign_in_with user
    visit '/'
  end

  scenario 'a user can change their own profile details' do
    first(:link, 'user').click
    click_link 'Editar Perfil'
    attach_file 'user[avatar]', 'spec/files/images/cat.jpg'
    fill_in 'user[bio]', with: 'Is this real life?'
    click_button 'Update Profile'

    expect(page.current_path).to eq profile_path('user')
    expect(page).to have_css "img[src*='avatar']"
    expect(page).to have_content 'Is this real life?'
  end

  scenario 'a user cannot change someone elses profile picture' do
    first(:link, 'usuario').click

    expect(page).to_not have_content 'Editar Perfil'
  end

  scenario "a user cannot navigate directly to edit a users profile" do
    visit "/usuario/edit"

    expect(page).to_not have_content 'Change your profile image'
    expect(page.current_path).to eq root_path
    expect(page).to have_content "That profile doesn't belongs to you"
  end
end
