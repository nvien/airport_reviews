require 'rails_helper'

feature 'search' do
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
    Airport.reindex
  end

  scenario 'user successfully searches for AN airport' do
    visit root_path
    expect(page).to have_content 'Denver International'
    expect(page).to have_content 'Dallas Fort Worth International'
    fill_in "search", with: "Denver"
    click_button 'Search'
    expect(page).to have_content 'Denver International'
    expect(page).to_not have_content 'Dallas Fort Worth International'
  end

  scenario 'user submits a blank search' do
    visit root_path
    fill_in "search", with: ""
    click_button 'Search'

    expect(page).to have_content 'Denver International'
    expect(page).to have_content 'Dallas Fort Worth International'
  end
end
