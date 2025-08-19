require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    log_in_as(@user)
  end

  test "should get new" do
    get new_entry_url, params: { start_time: Date.today }
    assert_response :success
  end
end
