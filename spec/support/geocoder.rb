Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      latitude:     42.351574,
      longitude:    -71.061387,
      address:      '33 Harrison Ave, Boston, MA, USA',
      city:         'Boston',
      state:        'Massachusetts',
      state_code:   'MA',
      country:      'United States',
      country_code: 'US'
    }
  ]
)
