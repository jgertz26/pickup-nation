class AttendeesController < ApplicationController
  def create
    meetup = Meetup.find(params["meetup_id"])
    Attendee.create(user: current_user, meetup: meetup)
    flash[:notice] = "Successfully joined game"
    redirect_to :back
  end

  def destroy
    meetup = Meetup.find(params["meetup_id"])
    Attendee.find_by(meetup: meetup, user: current_user).destroy
    flash[:notice] = "Successfully left game"
    redirect_to :back
  end
end
