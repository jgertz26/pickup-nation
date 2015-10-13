class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup

  validates :user, uniqueness: { scope: :meetup }
end
