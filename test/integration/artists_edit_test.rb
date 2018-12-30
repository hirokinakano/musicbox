require 'test_helper'

class ArtistsEditTest < ActionDispatch::IntegrationTest
  
  def setup 
    @artist = artists(:taro)
    @other_artist = artists(:ziro)
  end
  
  test "unsuccessful edit" do
    log_in_as(@artist)
    get edit_artist_path(@artist)
    assert_template "artists/edit"
    patch artist_path(@artist), params: { artist: { name: "",
                                                  email: "foo@invalid",
                                                  password: "foo",
                                                  password_confirmation: "bar"} }
    assert_template "artists/edit"
    assert_select "div#error_explanation"
  end
  
  test "successful edit with friendly forwarding" do
    log_in_as(@artist)
    name = "Foo Bar"
    email = "foo@bar.com"
    content = "FooBar"
    patch artist_path(@artist), params: { artist: { name:   name,
                                                    email: email,
                                                    password:              "",
                                                    password_confirmation: "",
                                                    content: content           } }
    assert_not flash.empty?
    assert_redirected_to @artist
    @artist.reload
    assert_equal name,  @artist.name
    assert_equal email, @artist.email
  end
  
  test "should redirect edit when not logged in" do
    get edit_artist_path(@artist)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch artist_path(@artist), params: { user: { name: @artist.name,
                                              email: @artist.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
