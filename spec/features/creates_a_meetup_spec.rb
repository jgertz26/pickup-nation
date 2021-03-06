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

    click_link "Schedule a Game"
    expect(page).to have_content("Schedule a game at #{court.name}")

    select('6 PM', from: 'start_hour')
    select('15', from: "start_minute")

    fill_in "description", with: "We gonna ball"
    click_button "Schedule Game"

    expect(page).to have_content("Games today:")
    expect(page).to have_content("6:15 pm")
    expect(page).to have_content("We gonna ball")
    expect(page).to have_content("Number of Hoops")
    expect(page).to have_content("Total attendees: 1")
    expect(page).to have_link("Leave Game")
    expect(page).to_not have_content("Later this week:")
  end

  scenario "user creates a meetup successfully later in the week" do

    sign_in(user)
    visit court_path(court)

    click_link "Schedule a Game"
    expect(page).to have_content("Schedule a game at #{court.name}")

    select((Date.today + 1).day, from: 'start_day')
    select('6 PM', from: 'start_hour')
    select('15', from: "start_minute")

    click_button "Schedule Game"

    expect(page).to have_content("Later this week:")
    expect(page).to have_content("6:15 pm")
    expect(page).to have_content("Number of Hoops")
    expect(page).to_not have_content("Games today:")
  end

  scenario "user is not signed in" do
    visit court_path(court)
    click_link "Schedule a Game"
    expect(page).to have_content("You need to log in to do that!")
  end
end
