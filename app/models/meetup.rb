class Meetup < ActiveRecord::Base
  belongs_to :user
  belongs_to :court
  has_many :attendees, dependent: :destroy

  after_create :create_attendee

  validates :start_time, presence: true

  validates :description, length: { maximum: 100 }
  validates :condition, length: { maximum: 100 }

  module MeetupTimes
    MEETUP_HOURS = [
      ["06", "6 AM"],["07", "7 AM"],["08", "8 AM"],["09", "9 AM"],
      ["10", "10 AM"],["11", "11 AM"],["12", "12 PM"],["13", "1 PM"],
      ["14", "2 PM"],["15", "3 PM"],["16", "4 PM"],["17", "5 PM"],
      ["18", "6 PM"],["19", "7 PM"],["20", "8 PM"],["21", "9 PM"],
      ["22", "10 PM"]
    ]

    MEETUP_MINUTES = ["00", "15", "30", "45"]

    def meetup_days
      days = []
      i = 0

      7.times do
        days << Date.today.next_day(i)
        i += 1
      end
      days
    end
  end

  private

  def create_attendee
    Attendee.create(meetup: self, user: self.user)
  end
end
