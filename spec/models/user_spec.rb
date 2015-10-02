require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
end
