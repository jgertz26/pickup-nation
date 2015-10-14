require 'rails_helper'

describe Meetup do
  let(:valid_strings) { ["We're going to hoop", nil] }
  let(:invalid_string) { "This is too long" * 10 }

  it { should belong_to(:court) }
  it { should belong_to(:user) }
  it { should have_many(:attendees) }

  it { should validate_presence_of(:start_time) }

  it { should have_valid(:description).when *valid_strings }
  it { should_not have_valid(:description).when invalid_string }

  it { should have_valid(:condition).when *valid_strings }
  it { should_not have_valid(:condition).when invalid_string }
end

describe Meetup, "#create_attendee" do
  it "creates makes user an attendee after creating a meetup" do
    meetup = FactoryGirl.create(:meetup)
    expect(meetup.attendees.length).to eq(1)
  end
end
