require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test "display stats of relationships for logged in users" do
    log_in_as(@user)

    get root_path
    assert_template 'static_pages/home'

    assert_select "div.stats a[href=?]", following_user_path(@user), count: 1
    assert_select "div.stats a[href=?]", followers_user_path(@user), count: 1
    assert_match "following", response.body
    assert_match "followers", response.body
  end
end
