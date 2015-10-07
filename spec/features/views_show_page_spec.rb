require "rails_helper"

feature "views show page", %(
As a baller,
I want to see details about a court
So I can determine if it's worth my time.
) do

  # Acceptance Criteria
  # [X] User can visit show page from index page by clicking the court name
  # [X] Info displayed includes address, hoop_count, paid?, hours

  scenario "user views all courts" do
    court_1 = FactoryGirl.create(:court, hours: "9AM-10:30PM")

    visit courts_path
    click_link court_1.name

    expect(page).to have_content(court_1.name)
    expect(page).to have_content(court_1.full_address)
    expect(page).to have_content(court_1.hoop_count)
    expect(page).to have_content(court_1.setting)
    expect(page).to have_content(court_1.hours)
    expect(page).to have_selector('div#googleMap')
  end
end
