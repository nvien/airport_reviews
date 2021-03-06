require 'rails_helper'

feature 'User creates a review' do
  let!(:user1) do
    User.create(
      first_name: "Bill",
      last_name: "Mirror",
      email: "abcd@email.com",
      password: "123123123",
      admin: true
    )
  end

  before(:each) do
    @airport = Airport.create(
      name: "Denver International",
      city: "Denver",
      IATA: "DEN"
    )

    visit new_user_session_path
    fill_in "Email", with: "abcd@email.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    visit airport_path("en",@airport.id)
  end

  scenario "user can fill in form and see their review posted" do
    click_link "Add a Review"
    fill_in "Rating", with: "5"
    fill_in "Description", with: "I love Denver"
    click_button "Create Review"

    expect(page).to have_content "Denver International"
    expect(page).to have_content "I love Denver"
  end

  scenario "user does not fill in required rating field receive error message" do
  click_link "Add a Review"
  fill_in "Rating", with: ""
  fill_in "Description", with: "I love Denver"
  click_button "Create Review"

  expect(page).to have_content "Rating can't be blank"
  expect(page).to have_content "Rating is not a number"
  expect(page).to have_content "Rating must be between 1-5"
  end
end
