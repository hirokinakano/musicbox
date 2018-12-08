require 'test_helper'

class ArtistsProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup 
    @artist = artists(:taro)
  end
  
  test "profile display" do
    get artist_path(@artist)
    assert_template 'artists/show'
    assert_select 'title', full_title(@artist.name)
    assert_select 'h2', text: @artist.name
    assert_select 'img'
  end
end
