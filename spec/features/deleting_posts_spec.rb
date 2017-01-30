require 'rails_helper'

feature 'Deleting posts' do
  background do
    user = create :user
    sign_in_with user
    post = create :post, caption: 'Abs for days', user_id: user.id
    
    find(:xpath, "//a[contains(@href, 'posts/1')]").click
  end

  scenario 'can delete a single post' do
    click 'Excluir'

    expect(page).to have_content 'Post deleted.'
    expect(page).to_not have_content 'Abs for days'
  end
end
