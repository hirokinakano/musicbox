require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup 
    @artist = artists(:taro)
    @post = @artist.posts.build(content: "Hello World")
  end
  
  test "should be valid" do
    assert @post.valid?
  end
  
  test "artist id should be present" do
    @post.artist_id = nil
    assert_not @post.valid?
  end
  
   test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 140 characters" do
    @post.content = "a" * 141
    assert_not @post.valid?
  end
  
  test "order shold be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
