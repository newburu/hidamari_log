require "test_helper"

class EntryFormTest < ActiveSupport::TestCase
  test "should be valid when content is within the character limit" do
    user = users(:one)
    user.update!(good_new_character_limit: 10)
    form = EntryForm.new(content: "short", user_id: user.id)
    assert form.valid?
  end

  test "should be invalid when content is over the character limit" do
    user = users(:one)
    user.update!(good_new_character_limit: 5)
    form = EntryForm.new(content: "too long", user_id: user.id)
    assert_not form.valid?
    assert_includes form.errors[:content], "は5文字以内で入力してください"
  end

  test "should use default limit if user has no limit set" do
    user = users(:one)
    # The `try` in the form object will handle if the attribute doesn't exist
    # and default to 250. Let's test against that.
    content = "a" * 251
    form = EntryForm.new(content: content, user_id: user.id)
    assert_not form.valid?
    assert_includes form.errors[:content], "は250文字以内で入力してください"
  end

  test "should be valid if content is blank" do
    # The presence validation is separate. This test ensures the length validation doesn't fail on blank content.
    user = users(:one)
    user.update!(good_new_character_limit: 5)
    form = EntryForm.new(content: "", user_id: user.id)
    # It will be invalid due to presence, but not due to length. Let's check that specific error is not present.
    form.valid? # run validations
    assert_not_includes form.errors[:content], "は5文字以内で入力してください"
  end
end
