require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup 
    @post = posts(:first_post)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference "Post.count" do
      post posts_path, params: { posts: {content: "Hello World" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Post.count" do
      delete post_path(@post) 
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong micropost" do
    log_in_as(artists(:ziro))
    post = posts(:first_post)
    assert_no_difference 'Post.count' do
      delete post_path(post)
    end
    assert_redirected_to root_url
  end
  
end
