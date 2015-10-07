require "rails_helper"

feature "pagination", %(
As a baller,
I want to see a list of basketball courts
But I only want to see 8 at a time.
) do

  # Acceptance Criteria
  # [X] User sees the first 8 courts
  # [X] User can click next to see the next 8
  # [X] User can click previous on following pages

  scenario "user views all courts" do
    court_1 = FactoryGirl.create(:court)
    7.times { FactoryGirl.create(:court) }
    court_2 = FactoryGirl.create(:court)

    visit courts_path

    expect(page).to have_content(court_1.name)
    expect(page).to_not have_content(court_2.name)

    click_link "Next"

    expect(page).to have_content(court_2.name)
    expect(page).to_not have_content(court_1.name)

    click_link "Prev"

    expect(page).to have_content(court_1.name)
    expect(page).to_not have_content(court_2.name)

  end
end
