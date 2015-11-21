class CourtType < ActiveRecord::Base
  has_many :courts

  validates :description, inclusion: {
    in: ['Outdoor without lights', 'Outdoor with lights', 'Indoor']
  }
end
