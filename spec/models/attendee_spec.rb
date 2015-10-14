require 'rails_helper'

describe Attendee do
  it { should belong_to(:meetup) }
  it { should belong_to(:user) }
end
