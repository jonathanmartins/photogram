require 'rails_helper'

feature 'Deleting posts' do
  background do
    user = create :user
    sign_in_with user
    @post = create :post, caption: 'Abs for days', user_id: user.id
  end

  scenario 'can delete a single post' do
    visit '/'
    find(:xpath, "//a[contains(@href, '/posts/#{@post.id}')]", match: :first).click
    click_link 'Excluir'

    expect(page).to have_content 'Post deleted.'
    expect(page).to_not have_content 'Abs for days'
  end
end
