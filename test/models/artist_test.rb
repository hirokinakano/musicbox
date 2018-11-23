require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  def setup
    @artist = Artist.new(name: "Example Artist", email: "artist@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end
  
  test "shold be valid" do
    assert @artist.valid?
  end
  
  test "name shold be present" do
    @artist.name = "   "
    assert_not @artist.valid?
  end
  
  test "email should be present" do
    @artist.email = "   "
    assert_not @artist.valid?
  end
  
  test "name should not be too long" do
    @artist.name = "a" * 51
    assert_not @artist.valid?
  end
  
  test "email should not be too long" do
    @artist.email = "a" * 244 + "@example.com"
    assert_not @artist.valid?
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @artist.email = invalid_address
      assert_not @artist.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresss should be unique" do
    duplicate_user = @artist.dup
    duplicate_user.email = @artist.email.upcase 
    @artist.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be present (nonblank)" do
    @artist.password = @artist.password_confirmation = " " * 6
    assert_not @artist.valid?
  end
  
  test "password should have a minimum length" do
    @artist.password = @artist.password_confirmation = "a" * 5
    assert_not @artist.valid?
  end

  test "associated posts should be destroyed" do
    @artist.save
    @artist.post.create(content: "Hello World")
    assert_difference 'Post.count', -1 do
      @artist.destroy
    end
  end
end
