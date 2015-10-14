require "rails_helper"

feature "creates a meetup", %(
As a baller,
I want to schedule a time to play
So others can join.
) do

  # Acceptance Criteria
  # [X] User can navigate to new meetup from show page
  # [X] Form by default is filled out to current day
  # [X] User fills out the form and hits submit, taken back to show page
  # [X] User must be signed in

  let(:court) { FactoryGirl.create(:court) }
  let(:user) { FactoryGirl.create(:user) }

  scenario "user creates a meetup successfully for the current day" do

    sign_in(user)
    visit court_path(court)

    click_link "Schedule a Meetup"
    expect(page).to have_content("Schedule a meetup at #{court.name}")

    select('06 PM', from: 'meetup_start_time_4i')
    select('15', from: "meetup_start_time_5i")

    fill_in "Description", with: "We gonna ball"
    click_button "Schedule Meetup"

    expect(page).to have_content("Meetups today:")
    expect(page).to have_content("6:15 pm")
    expect(page).to have_content("We gonna ball")
    expect(page).to have_content("Number of Hoops")
    expect(page).to have_content("Total attendees: 1")
    expect(page).to have_link("Leave Meetup")
    expect(page).to_not have_content("Later this week:")
  end

  scenario "user creates a meetup successfully later in the week" do

    sign_in(user)
    visit court_path(court)

    click_link "Schedule a Meetup"
    expect(page).to have_content("Schedule a meetup at #{court.name}")

    select((Date.today + 1).day, from: 'meetup_start_time_3i')
    select('06 PM', from: 'meetup_start_time_4i')
    select('15', from: "meetup_start_time_5i")

    click_button "Schedule Meetup"

    expect(page).to have_content("Later this week:")
    expect(page).to have_content("6:15 pm")
    expect(page).to have_content("Number of Hoops")
    expect(page).to_not have_content("Meetups today:")
  end

  scenario "user is not signed in" do
    visit court_path(court)
    click_link "Schedule a Meetup"
    expect(page).to have_content("You need to log in to do that!")
  end
end
