require 'rails_helper'

feature 'Deleting comments' do
  background do
    user = create :user
    user_two = create :user, username: 'user2', email: 'email2@email.com'
    @post = create :post, user_id: user.id
    @comment = create :comment, user_id: user_two.id, post_id: post.id
    @comment_two = create :comment, content: 'another comment', user_id: user.id, post_id: post.id
    sign_in_with user_two
  end
  #########################
  # Delete comments are using ajax + js, how to test it?
  #########################
  xscenario 'user can delete their own comments' do
    visit '/'
    expect(page).to have_content 'comment'
    click_link "delete#{@comment.id}"
    expect(page).to_not have_content 'comment'
  end

  scenario "user cannot delete a comment not belonging to them via ui" do
    visit '/'
    expect(page).to have_content 'another comment'
    expect(page).to_not have_css "delete-#{@comment_two.id}"
  end

  xscenario "user cannot delete a comment not belonging to them via url" do
    visit '/'
    expect(page).to have_content 'another comment'
    page.driver.submit :delete, "posts/#{@post.id}/comments/#{@comment_two.id}", {}
    expect(page).to have_content "That comment doesn't belongs to you!"
    expect(page).to have_content 'another comment'
  end
end
