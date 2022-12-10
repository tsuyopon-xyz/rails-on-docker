require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "layout links for not loggedin users" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", login_path, count: 1

    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")
  end

  test "layout links for logged in users" do
    log_in_as(@user)

    get root_path
    assert_template 'static_pages/home'

    # Header
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path, count: 1
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user), count: 1

    # Footer
    assert_select "a[href=?]", about_path, count: 1
    assert_select "a[href=?]", contact_path, count: 1
    assert_select "a[href=?]", "https://news.railstutorial.org/", count: 1

    get contact_path
    assert_select "title", full_title("Contact")

    get signup_path
    assert_select "title", full_title("Sign up")
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
