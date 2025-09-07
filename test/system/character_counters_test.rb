require "application_system_test_case"

class CharacterCountersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    # Assuming you have a login helper for system tests
    # In this app, we might need to simulate the session directly
    # or navigate through a login flow if one exists.
    # For now, we assume we can access the page as a logged-in user.
    # A real implementation would need a proper login helper.
    page.set_rack_session(user_id: @user.id)
  end

  test "character counter updates and shows warning" do
    visit new_entry_path(start_time: Time.zone.now)

    # Check initial state
    assert_selector "[data-character-counter-target='count']", text: "0"
    # The default for a new user will be nil in the DB, so the view will render 250
    assert_selector "[data-character-counter-target='limit']", text: "250"

    # Type within the limit
    fill_in "Good & New", with: "This is a test."
    assert_selector "[data-character-counter-target='count']", text: "15"
    assert_no_selector ".text-danger"

    # Type over the limit after setting one
    @user.update!(good_new_character_limit: 20)
    # We need to visit the page again to get the new limit in the HTML
    visit new_entry_path(start_time: Time.zone.now)

    assert_selector "[data-character-counter-target='limit']", text: "20"
    fill_in "Good & New", with: "This text is definitely over the new limit."
    assert_selector "[data-character-counter-target='count']", text: "42"
    assert_selector "[data-character-counter-target='counter'].text-danger"
  end
end
