# Pickup Nation

[ ![Codeship Status for jgertz26/pickup-nation](https://codeship.com/projects/1aae0fe0-4e6b-0133-1c3e-5a2039af3b63/status?branch=master)](https://codeship.com/projects/106907)
[![Code Climate](https://codeclimate.com/github/jgertz26/pickup-nation/badges/gpa.svg)](https://codeclimate.com/github/jgertz26/pickup-nation)
[![Coverage Status](https://coveralls.io/repos/jgertz26/pickup-nation/badge.svg?branch=master&service=github)](https://coveralls.io/github/jgertz26/pickup-nation?branch=master)

Pickup Nation helps users discover basketball courts in their area. Users can join existing games or create their own.  

##### Demo Site on Herkou
https://pickupnation.herokuapp.com/

##### Trello Board
https://trello.com/b/BQUT0aQN/pickup-nation

### Local Set Up Instructions

1. Clone git repository
2. In the project's root folder, run `gem install bundler`
3. `bundle install`
4. `rake db:create && db:migrate && db:seed`
5. `rails s`
6. You can now access the app at [localhost:3000](http://localhost:3000/)
