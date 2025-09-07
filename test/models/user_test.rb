require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should be valid with a positive character limit" do
    @user.good_new_character_limit = 100
    assert @user.valid?
  end

  test "should be invalid with a zero character limit" do
    @user.good_new_character_limit = 0
    assert_not @user.valid?
  end

  test "should be invalid with a negative character limit" do
    @user.good_new_character_limit = -10
    assert_not @user.valid?
  end

  test "should be invalid with a non-integer character limit" do
    @user.good_new_character_limit = 10.5
    assert_not @user.valid?
  end

  test "should be valid with a nil character limit" do
    @user.good_new_character_limit = nil
    assert @user.valid?
  end
end
