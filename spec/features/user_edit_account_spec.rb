require 'rails_helper'

feature "edit account", %{
  As an authenticated user
  I want to edit information of my account
} do

# ACCEPTANCE CRITERIA
# - I must specify valid email address
# - I must specify a password and confirm that password
# - If I do not perform the above, I get an error message
# - If I specify valid information, I successfully update my account

  let!(:user) do
    User.create(
      email: "abcd@email.com",
      password: "123123123"
    )
  end

  scenario 'user successfully change password' do
    visit new_user_session_path
    fill_in "Email", with: "abcd@email.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    visit edit_user_registration_path
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Current password", with: "123123123"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
  end

  scenario "user enter invalid current password" do
    visit new_user_session_path
    fill_in "Email", with: "abcd@email.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    visit edit_user_registration_path
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Current password", with: "123"
    click_button "Update"

    expect(page).to have_content("Current password is invalid")
  end
end
