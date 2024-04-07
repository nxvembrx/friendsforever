require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile = profiles(:one)
  end

  test "visiting the index" do
    visit profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "should create profile" do
    visit profiles_url
    click_on "New profile"

    fill_in "Banner picture", with: @profile.banner_picture
    fill_in "Bio", with: @profile.bio
    fill_in "Birthday", with: @profile.birthday
    fill_in "Display name", with: @profile.display_name
    fill_in "Location", with: @profile.location
    fill_in "Profile picture", with: @profile.profile_picture
    fill_in "Pronouns", with: @profile.pronouns
    fill_in "User", with: @profile.user_id
    fill_in "Website", with: @profile.website
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "should update Profile" do
    visit profile_url(@profile)
    click_on "Edit this profile", match: :first

    fill_in "Banner picture", with: @profile.banner_picture
    fill_in "Bio", with: @profile.bio
    fill_in "Birthday", with: @profile.birthday
    fill_in "Display name", with: @profile.display_name
    fill_in "Location", with: @profile.location
    fill_in "Profile picture", with: @profile.profile_picture
    fill_in "Pronouns", with: @profile.pronouns
    fill_in "User", with: @profile.user_id
    fill_in "Website", with: @profile.website
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "should destroy Profile" do
    visit profile_url(@profile)
    click_on "Destroy this profile", match: :first

    assert_text "Profile was successfully destroyed"
  end
end
