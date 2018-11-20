require 'test_helper'

class ListenersSignupTest < ActionDispatch::IntegrationTest

  def set up 
    @artist = listeners(:taro)
  end
  
  test "invalid signup information" do
    get new_listener_registration_path
    assert_no_difference 'Listener.count' do
      post listener_registration {name: '',
                                  email: '',
                                  password:               '',
                                  passoword_confirmation: ''
                                  }
                                  
  end 
end
