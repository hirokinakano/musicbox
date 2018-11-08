require 'test_helper'

class ArtistsIndexTest < ActionDispatch::IntegrationTest
 
  def setup 
    @artist = artists(:taro)
    @non_admin = artists(:ziro)
  end
  
  test "index including paggination" do
    log_in_as(@artist)
    get artists_path
    assert_template 'artists/index'
    assert_select 'div.pagination', count: 2
    first_page_of_artists = Artist.paginate(page: 1)
    first_page_of_artists.each do |artist|
      assert_select 'a[href=?]', artist_path(artist), text: artist.name
      unless artist == @admin
        assert_select 'a[href=?]', artist_path(artist), text: 'delete'
      end
    end
    assert_difference 'Artist.count', -1 do
      delete artist_path(@non_admin)
    end
  end
  
  test "index as non-admin" do
    log_in_as(@non_admin)
    get artists_path
    assert_select 'a', text: 'delete', count: 0
  end
end
