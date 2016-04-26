require 'rails_helper'

feature "admin deletes a review" do
  let!(:user1) do
    User.create(
      first_name: "Bill",
      last_name: "Mirror",
      email: "abcd@email.com",
      password: "123123123",
      admin: true
    )
  end

  let!(:user2) do
    User.create(
      first_name: "Manny",
      last_name: "Moore",
      email: "asdf@email.com",
      password: "123123123"
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

  let!(:review2) do
    Review.create(
      rating: "2",
      description: "I dont like laying over",
      airport: airport1,
      user: user2
    )
  end

  scenario "admin views list of reviews" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: "abcd@email.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    click_link "Denver International"

    expect(page).to have_content airport1.name
    expect(page).to have_content airport1.reviews.first.description
  end

  scenario "admin successfully deletes a review" do
    visit root_path
    click_link "Sign In"

    fill_in "Email", with: "abcd@email.com"
    fill_in "Password", with: "123123123"
    click_button "Log in"

    click_link "Denver International"

    expect(page).to have_content airport1.name
    expect(page).to have_content airport1.reviews.first.description

    click_link('Delete', match: :first)
    expect(page).to_not have_content review2.description
  end
end
