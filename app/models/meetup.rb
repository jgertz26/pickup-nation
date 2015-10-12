class Meetup < ActiveRecord::Base
  belongs_to :user
  belongs_to :court

  validates_presence_of :start_time

  validates :description, length: { maximum: 100 }
  validates :condition, length: { maximum: 100 }

end
