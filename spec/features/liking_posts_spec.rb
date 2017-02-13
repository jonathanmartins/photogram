require 'rails_helper'

feature 'Liking Posts' do
  background do
    user = create :user
    @post = create :post, user_id: user.id
    visit '/'
  end

  scenario 'can like a post' do
    click_button "like_#{@post.id}"
    expect(page).to have_css 'div.liked-post'
    expect(find('.post-likers')).to have_content 'user'
  end

  scenario 'can unlike a post' do
    click_button "like_#{@post.id}"
    expect(page).to have_css 'div.liked-post'
    expect(find('.post-likers')).to have_content 'user'

    click_button "like_#{@post.id}"
    expect(page).to have_css 'div.unliked-post'
    expect(find('.post-likers')).to_not have_content 'user'
  end
end
