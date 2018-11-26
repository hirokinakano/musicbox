require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @artist = artists(:taro)
  end
  
  test "post interface" do
    log_in_as(@artist)
    get root_path
    # 無効な送信
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # 有効な送信
    content = "This post is content for integration test"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content } } 
    end
    assert_redirected_to root_url
    follow_redirect!
    # 違うユーザーのプロフィールにアクセス(削除リンクがないことを確認)
    get artist_path(artists(:ziro))
    assert_select 'a', text: 'delete', count: 0
  end
end