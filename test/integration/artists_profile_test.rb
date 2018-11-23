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
    assert_select 'h1', text: @artist.name
    assert_select 'h1>img.gravatar'
    assert_match @artist.posts.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @artist.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end
