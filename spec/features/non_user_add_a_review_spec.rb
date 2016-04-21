require 'rails_helper'

feature "non user add a review" do

  let!(:airport) do
    Airport.create(
      name: "Hartsfield Jackson Atlanta International",
      city: "Atlanta",
      IATA: "ATL"
    )
  end

  scenario "non authenticated user attempt to add a review" do
    visit root_path
    click_link "Hartsfield Jackson Atlanta International"
    click_link "Add a Review"

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
