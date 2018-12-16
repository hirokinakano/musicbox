require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @artist = artists(:taro)
  end
  
end