require 'rails_helper'

describe CourtType do
  it { should have_many(:courts) }

  it { should have_valid(:description).when("Indoor") }
  it { should have_valid(:description).when("Outdoor with lights") }
  it { should_not have_valid(:description).when("Scooby Doo") }
end
