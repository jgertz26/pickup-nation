require "rails_helper"

feature "views show page", %(
As a baller,
I want to see details about a court
So I can see upcoming meetups.
) do

  # Acceptance Criteria
  # [X] User can visit show page from index page by clicking the court name
  # [X] Info displayed includes address, hoop_count, paid?, hours
  # [X] User should see meetups but no links edit or delete them

  scenario "user views show page" do
    court = FactoryGirl.create(:court, hours: "9AM-10:30PM")
    user_1 = FactoryGirl.create(:user)
    meetup_1 = FactoryGirl.create(:meetup,
                                  user: user_1,
                                  court: court,
                                  description: "Ballin")
    meetup_2 = FactoryGirl.create(:meetup,
                                  user: user_1,
                                  court: court,
                                  description: "Shot Callin",
                                  start_time: Time.now + 100000)
    meetup_3 = FactoryGirl.create(:meetup,
                                  user: user_1,
                                  court: court,
                                  description: "Not hoggin",
                                  start_time: Time.now + 10000000)

    visit courts_path
    click_link court.name

    expect(page).to have_content(court.name)
    expect(page).to have_content(court.full_address)
    expect(page).to have_content(court.hoop_count)
    expect(page).to have_content(court.setting)
    expect(page).to have_content(court.hours)
    expect(page).to have_content("Ballin")
    expect(page).to have_content("Shot Callin")
    expect(page).to_not have_content("Not hoggin")
    expect(page).to have_content(user_1.username)
    expect(page).to_not have_link("Provide update")
    expect(page).to_not have_link("Delete meetup")
  end
end
