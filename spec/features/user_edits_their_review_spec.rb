require 'rails_helper'

feature "user edits their review" do
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

  let!(:review1) do
    Review.create(
      rating: "5",
      description: "I love this airport",
      airport: airport1,
      user: user1
    )
  end

  before(:each) do
    visit new_user_session_path
  end

  scenario "user views edit page of review" do
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Log in"

    visit airport_path("en", airport1)
    page.find("#edit-link").click
    expect(page).to have_content "Editing Review"
  end

  scenario "user successfully edits their review" do
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Log in"

    visit airport_path("en", airport1)
    page.find("#edit-link").click
    fill_in "Rating", with: "3"
    fill_in "Description", with: "I changed my mind"
    click_button "Update Review"

    expect(page).to have_content "Review was successfully updated."
    expect(page.current_path).to eq airport_path("en", airport1)
    expect(page).to have_content "I changed my mind"
  end

  scenario "user unsuccessfully edits review" do
    fill_in "Email", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Log in"

    visit airport_path("en", airport1)
    page.find("#edit-link").click
    fill_in "Rating", with: ""
    fill_in "Description", with: "I changed my mind"
    click_button "Update Review"

    expect(page).to have_content "Rating must be between 1-5"
    expect(page).to have_content "Rating can't be blank"
    expect(page).to have_content "Editing Review"
  end
end
