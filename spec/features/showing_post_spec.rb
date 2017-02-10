require 'rails_helper'

feature 'Can view individual posts' do
  background do
    user = create :user
    @post = create :post, user_id: user.id

    sign_in_with user
  end

  scenario 'can click and view a single post' do
    visit '/'
    find(:xpath, "//a[contains(@href, '#{@post.id}')]", match: :first).click
    expect(page.current_path).to eq post_path(Post.first.id)
  end
end
