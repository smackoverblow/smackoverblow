require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "qwe1", email: "qwe@qwxaSDce.qwe", password: "qwerty",
      password_confirmation: "qwerty")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "eamil should be present" do
    @user.email = "a"*255+"example.com"
    assert_not @user.valid?
  end

  test "valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "invalid emails" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "unique emails" do
    dupl_user = @user.dup
    dupl_user.email = @user.email.upcase
    @user.save
    assert_not dupl_user.valid?
  end

  test "emails should be lower-cased" do
    mixed_email = "qWesaSF@qWqwEWs.CkoS"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end

  test "password nonblank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember,'')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "lorem ipsum again")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow user" do
    michael = users(:michael)
    archer = users(:archer)
    assert_not michael.following?(archer)
    michael.follow archer
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

end
