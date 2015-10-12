require 'rails_helper'

describe User do
  it { should have_many(:meetups) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
end
