require "rails_helper"

feature "creates a court", %(
As a baller
I want to submit a court
So I can schedule games there
) do

  # Acceptance Criteria
  # [X] User can visit new court page from nav_bar page
  # [X] User fills in necessary information, submits, and is taken to the
  #     show page, with a success message
  # [X] User must be logged in
  # [X] User sees errors if information is invalid

  let(:user) { FactoryGirl.create(:user) }

  scenario "user submits correctly", js: true do
    court = FactoryGirl.build(:court, hours: "TIME")

    visit root_path
    sign_in(user)
    click_link "Add New Court"

    expect(page).to have_content("Submit New Court")

    fill_in "Name of court", with: court.name
    fill_in "Street address", with: court.street_address
    fill_in "City", with: court.city
    fill_in "State", with: court.state
    fill_in "Zip Code", with: court.zip
    fill_in "Number of hoops", with: court.hoop_count
    select('Indoor', from: 'Setting')
    fill_in "Hours", with: court.hours
    click_button "Add Court"

    expect(page).to have_content("Click on the map")

    page.find(".gm-style").click
    click_link "Submit"

    expect(page).to have_content("Court added!")
    expect(page).to have_content(court.name)
    expect(page).to have_content(court.hoop_count)
  end

  scenario "user is not logged in" do

    visit root_path
    click_link "Add New Court"

    expect(page).to have_content("You need to log in to do that!")
    expect(page).to have_content("Welcome to Pickup Nation")

  end

  scenario "user submits blank form", js: true do
    sign_in(user)
    visit new_court_path

    expect(page).to have_content("Submit New Court")

    click_button "Add Court"

    expect(page).to have_content("Submit New Court")
    expect(page).to have_content("Address not recognized. Try again!")
  end

  scenario "user submits valid address with nothing else", js: true do
    court = FactoryGirl.build(:court, hours: "TIME")

    visit root_path
    sign_in(user)
    click_link "Add New Court"

    expect(page).to have_content("Submit New Court")

    fill_in "Street address", with: court.street_address
    fill_in "City", with: court.city
    fill_in "State", with: court.state
    fill_in "Zip Code", with: court.zip
    click_button "Add Court"

    expect(page).to have_content("Click on the map")

    page.find(".gm-style").click
    click_link "Submit"

    expect(page).to have_content("Submit New Court")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Hoop count can't be blank")
    expect(page).to have_content("Hoop count is not a number")
  end
end
