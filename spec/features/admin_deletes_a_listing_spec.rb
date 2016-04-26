require 'rails_helper'

feature "admin deletes an airport listing" do
  let!(:user1) do
    User.create(
      first_name: "Bill",
      last_name: "Mirror",
      email: "abcd@email.com",
      password: "123123123",
      admin: true
    )
  end

  let!(:airport1) do
    Airport.create(
      name: "Denver International",
      city: "Denver",
      IATA: "DEN"
    )
  end

  scenario "admin successfully deletes an airport" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: "abcd@email.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"
    expect(page).to have_content "Denver International"

    click_link('Destroy', match: :first)

    expect(page).to have_content "Airport was successfully destroyed."
  end
end
