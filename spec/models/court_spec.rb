require 'rails_helper'

describe Court do
  it { should have_many(:meetups) }
  it { should belong_to(:court_type) }

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

describe Court, "#setting" do
  it "returns a string describing the court_type" do
    court_type = FactoryGirl.create(:court_type, description: "Indoor")
    court = FactoryGirl.create(:court, court_type: court_type)
    expect(court.setting).to eq("Indoor")
  end
end

describe Court, "#meetups_today" do
  it "returns an array of meetups occurring today in order by time" do
    court = FactoryGirl.create(:court)
    meetup_1 = FactoryGirl.create(
      :meetup,
      court: court,
      start_time: (Time.now - 5.hours)
    )
    meetup_2 = FactoryGirl.create(
      :meetup,
      court: court,
      start_time: (Time.now - 7.hours)
    )
    FactoryGirl.create(
      :meetup,
      court: court,
      start_time: (Time.now - 4.hours + 9.days)
    )
    expect(court.meetups_today).to eq([meetup_2, meetup_1])
  end
end

describe Court, "#meetups_this week" do
  it "returns an array of meetups occurring this week but not today in order" do
    court = FactoryGirl.create(:court)
    FactoryGirl.create(
      :meetup,
      court: court
    )
    meetup_2 = FactoryGirl.create(
      :meetup,
      court: court,
      start_time: (Time.now - 4.hours + 3.days)
    )
    meetup_3 = FactoryGirl.create(
      :meetup,
      court: court,
      start_time: (Time.now - 4.hours + 2.days)
    )
    expect(court.meetups_this_week).to eq([meetup_3, meetup_2])
  end
end
