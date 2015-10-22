class AttendeesController < ApplicationController
  def create
    meetup = Meetup.find(params["meetupId"])
    attendee_action = params["attendeeAction"]

    if attendee_action == "Join Game"
      Attendee.create(user: current_user, meetup: meetup)
    else
      Attendee.find_by(meetup: meetup, user: current_user).destroy
    end

    total_attendees = meetup.attendees.length.to_s
    respond_to do |format|
      format.json { render json: total_attendees }
    end
  end
end
