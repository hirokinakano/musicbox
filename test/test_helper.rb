ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  # テストユーザーがログイン中の場合にtrueを返す
  def is_logged_in?
    !session[:user_id].nil?
  end
  
    # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  
  # テストユーザーとしてログインする
  def log_in_as(user,password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password,} }
  end
  
  #テスト用のイメージ画像を返す
  def image_test
    Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'images', 'test.png'), 'image/png')
  end
  
end
