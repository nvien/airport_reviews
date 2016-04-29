require 'rails_helper'

feature "new user can sign up to post reviews" do

  # ACCEPTANCE CRITERIA
  # - I must specify valid email address
  # - I must specify a password and confirm that password
  # - If I do not perform the above, I get an error message
  # - If I specify valid information, my account is registered and I'm
  #  authenticated

  let!(:user) do
    User.create(
      first_name: "Bill",
      last_name: "Mirror",
      email: "abcd@email.com",
      password: "123123123"
    )
  end

  scenario 'specifiying valid and required information' do
    visit new_user_registration_path
    fill_in 'First name', with: "Kobe"
    fill_in 'Last name', with: "Puppy"
    fill_in 'Email', with: "kobe@travel.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Submit'

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario 'user enters the email that is already existing' do
    visit new_user_registration_path
    fill_in 'First name', with: "Kobe"
    fill_in 'Last name', with: "Puppy"
    fill_in 'Email', with: "abcd@email.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Submit'
    expect(page).to have_content("1 error prohibited this user from
     being saved:")
    expect(page).to have_content("Email has already been taken")
  end

  scenario 'user does not provide any information' do
    visit new_user_registration_path
    fill_in 'First name', with: ""
    fill_in 'Last name', with: ""
    fill_in 'Email', with: ""
    fill_in 'Password', with: ""
    fill_in 'Password confirmation', with: ""
    click_button 'Submit'

    expect(page).to have_content("4 errors prohibited this user from
     being saved:")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end

  scenario 'user provides invalid information' do
    visit new_user_registration_path
    fill_in 'First name', with: "Kobe"
    fill_in 'Last name', with: "Puppy"
    fill_in 'Email', with: "asdf@asdf"
    fill_in 'Password', with: "asdf"
    fill_in 'Password confirmation', with: "asdf"
    click_button 'Submit'

    expect(page).to have_content("2 errors prohibited this user from
     being saved:")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password is too short")
  end
end
