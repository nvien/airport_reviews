require 'rails_helper'

feature 'user see reviews' do
  let!(:user1) do
    User.create(
      email: "abcd@email.com",
      password: "123123123"
    )
  end

  let!(:user2) do
    User.create(
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

  scenario 'user visits airport show page and sees list of reviews' do
    visit airport_path(airport1)

    expect(page).to have_content "I love this airport"
    expect(page).to have_content "I dont like laying over"
  end





  # scenario "User sees average review score", :vcr do
  #     visit item_path(item)
  #
  #     expect(page).to have_content "Average Review Score: 3.0"
  #   end

    # scenario "User visits item show page to see reviews, sees page numbers for additional reviews", :vcr do
    #   item_2 = create(:item_with_100_reviews)
    #   visit item_path(item_2)
    #   expect(page).to have_link("2")
    #   expect(page).to have_link("3")
    #   expect(page).to have_link("Next ›")
    #   expect(page).to have_link("Last »")
    # end

    # scenario "User sees order newest to oldest", :vcr do
    #   visit item_path(item)
    #
    #   within("ul#review_list") do
    #     expect(page).to have_selector("#review-0", text: review_3.description)
    #     expect(page).to have_selector("#review-1", text: review_2.description)
    #     expect(page).to have_selector("#review-2", text: review_1.description)
    #   end
    # end

end
