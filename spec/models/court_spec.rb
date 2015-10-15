require 'rails_helper'

describe Court do
  it { should have_many(:meetups) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:hoop_count) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }

  it { should have_valid(:state).when("RI") }
  it { should_not have_valid(:state).when("ripa") }
  it { should_not have_valid(:state).when("MP") }

  it { should have_valid(:hoop_count).when(24) }
  it { should_not have_valid(:hoop_count).when(300) }

  it { should have_valid(:zip).when("02288") }
  it { should_not have_valid(:zip).when("jimbo") }

  it { should have_valid(:setting).when("Indoor") }
  it { should have_valid(:setting).when("Outdoor with lights") }
  it { should_not have_valid(:setting).when("Scooby Doo") }
end

describe Court, "#full_address" do
  it "returns a formatted string of the complete address" do
    court = FactoryGirl.create(
      :court,
      street_address: "33 Harrison Ave",
      city: "Boston",
      state: "MA",
      zip: "02111"
    )

    expect(court.full_address).to eq("33 Harrison Ave Boston, MA 02111")
  end

end
