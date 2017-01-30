require 'rails_helper'

feature 'Creating comments' do

  # No Submit button, using ajax + js, how to test it?
  xscenario 'can create a comment' do
    user = create :user
    post = create :post, user_id: user.id
    sign_in_with user
    visit '/'
    fill_in placeholder: 'Add a comment...', with: ";P"
    click_button 'Submit'
    expect(page).to have_css "div.comments#{Post.last.id}", text: ";P"
  end
end
