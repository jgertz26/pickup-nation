require "rails_helper"

feature "views index page", %(
As a baller,
I want to see a list of basketball courts
So that I can find one near me that suits my needs.
) do

  #Acceptance Criteria
  #[X] User sees all courts
  #[ ] Courts are listed based on proximity

  scenario "user views all courts" do
    court_1 = FactoryGirl.create(:court)
    court_2 = FactoryGirl.create(:court)

    visit courts_path
    save_and_open_page
    expect(page).to have_content(court_1.name)
    expect(page).to have_content(court_1.full_address)
    expect(page).to have_content(court_2.name)
    expect(page).to have_content(court_2.full_address)
  end
end
