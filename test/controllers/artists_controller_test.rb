require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
 
 def setup
   @artist = artists(:taro)
   @other_artist = artists(:ziro)
 end
 
  test "should get new" do
    get artists_new_url
    assert_response :success
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Artist.count' do
      delete artist_path(@artist)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_artist)
    assert_no_difference 'Artist.count' do
      delete artist_path(@artist)
    end
    assert_redirected_to root_url
  end
end
