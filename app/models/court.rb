class Court < ActiveRecord::Base
  has_many :meetups, dependent: :destroy
  belongs_to :court_type

  geocoded_by :full_address

  paginates_per 8

  validates :name, :hoop_count, :street_address, :city, :state,
            :zip, :latitude, :longitude,
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

  validates_uniqueness_of :street_address,
    scope: [:city, :state, :zip],
    message: "is already in the system"

  validates :zip, length: { is: 5 }, numericality: { only_integer: true }

  def full_address
    "#{street_address} #{city}, #{state} #{zip}"
  end

  def setting
    binding.pry
    court_type.description
  end

  def meetups_today
    results = []
    meetups.each do |meetup|
      meetup_date = meetup.start_time.to_date
      if meetup_date == Date.today
        results << meetup
      end
    end
    results.sort_by! { |m| m.start_time }
  end

  def meetups_this_week
    results = []
    today = Date.today
    meetups.each do |meetup|
      meetup_date = meetup.start_time.to_date
      if meetup_date > today && meetup_date < (today + 7.days)
        results << meetup
      end
    end
    results.sort_by! { |m| m.start_time }
  end
end
