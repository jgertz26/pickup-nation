class Meetup < ActiveRecord::Base
  belongs_to :user
  belongs_to :court
  has_many :attendees, dependent: :destroy

  after_create :create_attendee

  validates :start_time, presence: true

  validates :description, length: { maximum: 100 }
  validates :condition, length: { maximum: 100 }

  private

  def create_attendee
    Attendee.create(meetup: self, user: self.user)
  end
end
