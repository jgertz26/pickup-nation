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
      ["6 AM", "06"], ["7 AM","07"], ["8 AM", "08"], ["9 AM", "09"],
      ["10 AM", "10"], ["11 AM", "11"], ["12 PM", "12"], ["1 PM", "13"],
      ["2 PM", "14"], ["3 PM", "15"], ["4 PM", "16"], ["5 PM", "17"],
      ["6 PM", "18"], ["7 PM", "19"], ["8 PM", "20"], ["9 PM", "21"],
      ["10 PM", "22"]
    ]

    MEETUP_MINUTES = ["00", "15", "30", "45"]

    def week_days
      days = [["Today", 0]]
      i = 1

      6.times do
        days << [Date.today.next_day(i).strftime('%a, %b. %e'), (i)]
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
