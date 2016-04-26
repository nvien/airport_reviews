require 'rails_helper'

feature "user deletes their account permanently" do
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
      user: user2
    )
  end

  before(:each) do
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: "asdf@email.com"
    fill_in 'Password', with: "123123123"
    click_button "Log in"

    click_link "Edit Profile"
    click_button 'Delete my account'
  end

  scenario 'user successfully deletes account' do
    expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
    expect(page).to have_content("Sign Up")
  end

  scenario 'his/her review is deleted when the account is deleted' do
    visit airport_path("en", airport1)

    expect(page).to_not have_content "I love this airport"
    expect(page).to have_content "No Reviews Yet. Be the first to write one!"
  end
end
