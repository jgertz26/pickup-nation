class Meetup < ActiveRecord::Base
  belongs_to :user
  belongs_to :court

  validates :start_time, presence: true

  validates :description, length: { maximum: 100 }
  validates :condition, length: { maximum: 100 }
end
