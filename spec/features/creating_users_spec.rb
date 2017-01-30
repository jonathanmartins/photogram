require 'rails_helper'

feature 'Creating a new user' do
  background do
    visit '/'
    click_link 'Register'
  end

  scenario 'can create a new user via index page' do
    fill_in 'Username', with: 'railsdev'
    fill_in 'Email', with: 'email@railsdev.com'
    fill_in 'Password', with: '123456', match: :first
    fill_in 'Confirm Password', with: '123456'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'requires a username to create user' do
    fill_in 'Email', with: 'email@railsdev.com'
    fill_in 'Password', with: '123456', match: :first
    fill_in 'Confirm Password', with: '123456'
    click_button 'Sign up'

    expect(page).to have_content "can't be blank"
  end

  scenario 'requires a username to be more than 4 characters' do
    fill_in 'Username', with: 'rai'
    fill_in 'Email', with: 'email@railsdev.com'
    fill_in 'Password', with: '123456', match: :first
    fill_in 'Confirm Password', with: '123456'
    click_button 'Sign up'

    expect(page).to have_content 'minimum is 4 characters'
  end

  scenario 'requires a username to be less than 16 characters' do
    fill_in 'Username', with: 'railsdeveloperprofessional'
    fill_in 'Email', with: 'email@railsdev.com'
    fill_in 'Password', with: '123456', match: :first
    fill_in 'Confirm Password', with: '123456'
    click_button 'Sign up'

    expect(page).to have_content 'maximum is 16 characters'
  end
end
