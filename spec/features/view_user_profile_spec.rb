require 'rails_helper'

feature 'viewing user profiles' do
  background do
    user = create(:user)
    user2 = create(:user, email: 'email2@email.com',
                          username: 'user2')
    post = create(:post, user_id: user.id)
    post2 = create(:post, user_id: user2.id, caption: 'other caption')

    sign_in_with user
    visit "/"
    first('.username').click_link 'user'
  end

  xscenario 'visiting a profile page shows the user name in the url' do
    expect(page.current_path).to eq(profile_path('user'))
  end

  xscenario "a profile page only shows the specified user's posts" do
    expect(page).to have_content 'caption default'
    expect(page).to_not have_content 'other caption'
  end
end