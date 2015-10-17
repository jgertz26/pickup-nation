require "rails_helper"

feature "deletes a meetup", %(
As a baller,
I want to delete a meetup
Because I changed my mind.
) do

  # Acceptance Criteria
  # [X] User can delete meetup from show page
  # [X] User and admins have this capability
  # [X] User should see a notification of success and be taken to show page

  let(:court) { FactoryGirl.create(:court) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, admin: true) }

  background do
    FactoryGirl.create(:meetup, court: court, user: user)
  end

  scenario "user deletes meetup" do

    sign_in(user)
    visit court_path(court)

    click_link "Delete game"

    expect(page).to have_content("Game successfully deleted")
    expect(page).to have_content("Number of Hoops")
  end

  scenario "admin deletes meetup" do

    sign_in(admin)
    visit court_path(court)

    click_link "Delete game"

    expect(page).to have_content("Game successfully deleted")
    expect(page).to have_content("Number of Hoops")
  end
end
