require "rails_helper"

feature "deletes a court", %(
As a baller
I want to delete a court
Because someone built an apartment complex on it
) do

  # Acceptance Criteria
  # [X] User can click delete link on edit page
  # [X] User must be logged in, and an admin
  # [X] User is taken to the homepage with success message

  let(:court) { FactoryGirl.create(:court) }
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, admin: true) }


  scenario "user visits edit page" do
    sign_in(user)
    visit edit_court_path(court)

    expect(page).to have_content("Edit Court")
    expect(page).to_not have_content("Delete Court")

  end

  scenario "admin deletes successfully" do
    sign_in(admin)
    visit edit_court_path(court)

    expect(page).to have_content("Edit Court")

    click_link "Delete Court"

    expect(page).to have_content("Court deleted!")
    expect(page).to have_content("Courts")

  end
end
