require "rails_helper"

feature "joins a meetup", %(
As a baller,
I want to join a meetup
So that others can know I'm coming.
) do

  # Acceptance Criteria
  # [X] User can join a meetup on the show page
  # [X] When user joins the button becomes a leave button, and vice versa
  # [X] User should see notifications for either scenario
  # [X] User must be logged in to see buttons

  let(:court) { FactoryGirl.create(:court) }
  let(:user_1) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user) }

  scenario "user successfully joins a meetup" do
    FactoryGirl.create(:meetup, court: court, user: user_1)

    sign_in(user_2)
    visit court_path(court)

    expect(page).to have_content("Total attendees: 1")

    click_link "Join Game"

    expect(page).to have_content("Successfully joined game")
    expect(page).to have_link("Leave Game")
    expect(page).to_not have_link("Join Game")
    expect(page).to have_content("Total attendees: 2")
  end

  scenario "user successfully leaves meetup" do
    meetup = FactoryGirl.create(:meetup, court: court, user: user_1)
    Attendee.create(meetup: meetup, user: user_2)

    sign_in(user_2)
    visit court_path(court)

    expect(page).to have_content("Total attendees: 2")

    click_link "Leave Game"

    expect(page).to have_content("Successfully left game")
    expect(page).to have_link("Join Game")
    expect(page).to_not have_link("Leave Game")
    expect(page).to have_content("Total attendees: 1")
  end

  scenario "user is not signed in" do
    visit court_path(court)
    expect(page).to_not have_link("Join Game")
    expect(page).to_not have_link("Leave Game")
  end
end
