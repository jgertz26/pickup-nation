class Court < ActiveRecord::Base
  has_many :meetups, dependent: :destroy

  geocoded_by :full_address

  paginates_per 8

  validates :name, :hoop_count, :street_address, :city, :state, :zip, :setting,
            presence: true
  validates :hoop_count, numericality: { only_integer: true, less_than: 30 }

  validates :state, inclusion: { in: ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT',
                                      'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID',
                                      'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD',
                                      'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC',
                                      'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY',
                                      'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD',
                                      'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI',
                                      'WV', 'WY'],
                                 message: "is invalid" }

  validates :setting, inclusion: {
    in: ['Outdoor without lights', 'Outdoor with lights', 'Indoor']
  }

  validates :zip, length: { is: 5 }, numericality: { only_integer: true }

  def full_address
    "#{street_address} #{city}, #{state} #{zip}"
  end
end
