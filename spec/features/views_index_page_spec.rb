require "rails_helper"

feature "views index page", %(
As a baller,
I want to see a list of basketball courts
So that I can find one near me that suits my needs.
) do

  # Acceptance Criteria
  # [X] User sees all courts
  # [ ] Courts are listed based on proximity
  # [ ] User can see if a game is happening on the current day

  scenario "user views all courts with games happening" do
    court_1 = FactoryGirl.create(:court)
    court_2 = FactoryGirl.create(:court)
    meetup = FactoryGirl.create(:meetup, court: court_2)

    visit courts_path
    expect(page).to have_content(court_1.name)
    expect(page).to have_content(court_1.full_address)
    expect(page).to have_content(court_2.name)
    expect(page).to have_content(court_2.full_address)
    expect(page).to have_content("Games happening today")
    expect(page).to have_selector('div#indexMap')
  end

  scenario "user views all courts with no games happening" do
    court_1 = FactoryGirl.create(:court)
    court_2 = FactoryGirl.create(:court)

    visit courts_path
    expect(page).to have_content(court_1.name)
    expect(page).to have_content(court_1.full_address)
    expect(page).to have_content(court_2.name)
    expect(page).to have_content(court_2.full_address)
    expect(page).to_not have_content("Games happening today")
  end
end
