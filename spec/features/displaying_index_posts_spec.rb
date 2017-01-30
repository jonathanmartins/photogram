require 'rails_helper'

feature 'Index displays a list of posts' do
  background do
    user = create :user
    post_one = create :post, caption: "This is post one", user_id: user.id
    post_two = create :post, caption: "This is post two", user_id: user.id
    sign_in_with user
  end

  scenario 'the index displays correct created post info' do
    visit '/'
    expect(page).to have_content "This is post one"
    expect(page).to have_content "This is post two"
    expect(page).to have_css "img[src*='cat']"
  end
end
