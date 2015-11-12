require "rails_helper"

feature "updates a meetup", %(
As a baller,
I want to see update a meetup
To let users know the conditions of the court.
) do

  # Acceptance Criteria
  # [X] User can navigate to edit meetup page from show page
  # [X] User can only find links to update their own meetup
  # [X] User should see a notification of success and be taken to show page

  let(:court) { FactoryGirl.create(:court) }
  let(:user_1) { FactoryGirl.create(:user) }
  let(:user_2) { FactoryGirl.create(:user) }

  background do
    FactoryGirl.create(
      :meetup,
      court: court,
      user: user_1,
      start_time: Time.now + 6.hours
    )
  end

  scenario "user with no meetups views show page" do

    sign_in(user_2)
    visit court_path(court)

    expect(page).to_not have_link("Provide Update")
    expect(page).to_not have_link("Delete Game")
  end

  scenario "user updates meetup" do

    sign_in(user_1)
    visit court_path(court)

    expect(page).to have_content("Provide update")
    click_link "Provide update"

    fill_in "Updates", with: "People showed up!"
    click_button "Update Game"
    expect(page).to have_content("Game updated!")
    expect(page).to have_content("Number of Hoops")
    expect(page).to have_content("People showed up")
    expect(page).to have_content("- less than a minute ago")
  end
end
