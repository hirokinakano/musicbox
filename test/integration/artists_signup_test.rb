require 'test_helper'

class ArtistsSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    @artist = artists(:taro)
  end
  
  test "invalid signup information" do
    get new_artist_path
    assert_no_difference 'User.count' do
      post artists_path, params: { artist: { name:                  "",
                                             email:                 "",
                                             password:              "bar",
                                             password_confirmation: "foo" ,  } }
    
    end
    assert_template "artists/new"
    assert_select 'div#error_explanation'
  end
  
  test "valid signup information" do
    get new_artist_path
    assert_no_difference 'User.count', 1 do
      post artists_path, params: { artist: { name:                  "Example User",
                                             email:                 "user@example.com",
                                             password:              "password",
                                             password_confirmation: "password",
                                             image:                 image_test          } }
    end
    follow_redirect!
    assert_template 'toppages/index'
    assert_select 'div.alert'
  end
  
  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: {email: "", password: ""} }
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
    test "login with valid information followed by logout" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {email: @artist.email,
                                        password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @artist
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", artist_path(@artist)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
  end
end


