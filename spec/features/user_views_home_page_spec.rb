require 'rails_helper'

feature "User views index page to see items" do

  let!(:airport1) do
    Airport.create(
      name: "Denver International",
      city: "Denver",
      IATA: "DEN"
    )
  end

  let!(:airport2) do
    Airport.create(
      name: "Dallas Fort Worth International",
      city: "Dallas-Fort Worth",
      IATA: "DFW"
    )
  end

  scenario "User sees list of airports" do
    visit root_path

    expect(page).to have_link airport1.name
    expect(page).to have_link airport2.name
  end

  scenario "User clicks airport link, gets taken to that airport show page" do
    visit root_path

    click_link airport1.name

    expect(page).to have_content airport1.name
    expect(page).to have_content airport1.city
  end
end
