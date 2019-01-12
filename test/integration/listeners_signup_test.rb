require 'test_helper'

class ListenersSignupTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @listener = listeners(:hoge)
  end

  test "valid information signin through signout" do
    get root_path
    assert_template 'toppages/index'
    get new_listener_session_path
    assert_template 'listeners/sessions/new'

  end
end
