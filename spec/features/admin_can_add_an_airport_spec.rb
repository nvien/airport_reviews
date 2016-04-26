require 'rails_helper'

feature "Admin submit a new airport" do
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

  before(:each) do
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: "abcd@email.com"
    fill_in 'Password', with: "123123123"
    click_button "Log in"
  end

  scenario "Admin submit a new airport" do
    click_link "New Airport"
    expect(page).to have_content("New Airport")

    fill_in "Name", with: "San Francisco International"
    fill_in "City", with: "San Francisco"
    fill_in "Iata", with: "SFO"
    fill_in "Website", with: "http://www.flysfo.com/"
    click_button "Create Airport"

    expect(page).to have_content "San Francisco International"
    expect(page).to have_content "SFO"
  end

  scenario "Admin doesn't complete new airport form receives error" do
    click_link "New Airport"

    click_button "Create Airport"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "Iata can't be blank"
  end

  scenario "Admin enters an airport that was previously created receives error" do
    click_link "New Airport"
    fill_in "Name", with: "Denver International"
    click_button "Create Airport"

    expect(page).to have_content "Name has already been taken"
  end
end
