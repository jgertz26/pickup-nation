require "rails_helper"

feature "edits a court", %(
As a baller
I want to edit a court
Because somebody put some wrong information
) do

  #Acceptance Criteria
  #[X] User can visit edit court page from the show page
  #[X] User fills in necessary information, submits, and is taken to the
  #    show page, with a success message
  #[X] User must be logged in
  #[X] User sees errors if information is invalid

  let(:court) { FactoryGirl.create(:court) }
  let(:user) { FactoryGirl.create(:user) }

  scenario "user submits correctly" do

    sign_in(user)
    visit court_path(court)
    click_link "Edit Court"

    expect(page).to have_content("Edit Court")

    fill_in "Hours", with: "always"
    click_button "Update Court"

    expect(page).to have_content("Court updated!")
    expect(page).to have_content(court.name)
    expect(page).to have_content(court.hoop_count)

  end

  scenario "user is not logged in" do
    visit edit_court_path(court)

    expect(page).to have_content("You need to log in to do that!")
    expect(page).to have_content("Discover Courts")

  end

  scenario "user submits invalid form" do
    sign_in(user)
    visit edit_court_path(court)

    expect(page).to have_content("Edit Court")

    bad_data = "a bunch of numbers"
    fill_in "Zip", with: bad_data
    fill_in "State", with: bad_data
    fill_in "Number of hoops", with: bad_data

    click_button "Update Court"

    expect(page).to have_content("Edit Court")
    expect(page).to have_content("Hoop count is not a number")
    expect(page).to have_content("State is invalid")
    expect(page).to have_content("Zip is the wrong length (should be 5 characters)")
    expect(page).to have_content("Zip is not a number")

  end
end
