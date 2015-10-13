class AttendeesController < ApplicationController
  def create
    meetup = Meetup.find(params["meetup_id"])
    Attendee.create(user: current_user, meetup: meetup)
    binding.pry

  end

  def destroy
  end

end
