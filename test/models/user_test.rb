require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid initially" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "             "
    assert_not @user.valid?
  end

  test "Email shouldn't be too long" do
    @user.email = "a"*244 + "@example.com"
  end

  test "should deny invalid email addresses" do
    invalid_addresses = ["foo.bar.com", "error.h@", "foo@bar", "user@exmaple,com"]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "should accept valid email addresses" do
    valid_addresses = %w[FoO.bar@exmaple.com user@foo.COM first-la+st@foo.jp]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be valid."
    end
  end

  test "email shoud be lower case" do
    @user.email = "FOO@BAR.CoM"
    @user.save
    assert_equal @user.reload.email, "foo@bar.com"
  end

  test "Email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = " "*8
    assert_not @user.valid?
  end

  test "password shouldn't be too short" do
    @user.password = "a"*7
    assert_not @user.valid?
  end

  test "associated list categories should be destroyed" do
    @user.save
    @user.categories.create!(title: "Test")
    assert_difference 'Category.count', -1 do
      @user.destroy
    end
  end

  test "should join and exit team" do
    user = users(:matt)
    team = teams(:work)
    assert_not user.member?(team)
    user.join(team)
    assert user.member?(team)
    user.leave(team)
    assert_not user.member?(team)
  end

end
