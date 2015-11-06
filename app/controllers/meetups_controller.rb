class MeetupsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  include Meetup::MeetupTimes

  def new
    @court = Court.find(params["court_id"])
    @meetup = Meetup.new
    @days = week_days.map { |m| [m[0].strftime('%a, %b. %e'), m[1]] }
    @hours = MEETUP_HOURS
    @minutes = MEETUP_MINUTES
  end

  def create
    @court = Court.find(params["court_id"])
    @meetup = Meetup.new(meetup_create_params)

    if @meetup.save
      flash[:sucess] = "Game scheduled!"
      redirect_to court_path(@court)
    else
      flash[:alert] = @meetup.errors.full_messages.join(" - ")
      render :new
    end
  end

  def edit
    @meetup = Meetup.find(params["id"])
    @court = @meetup.court
  end

  def update
    @meetup = Meetup.find(params["id"])
    @court = @meetup.court

    if @meetup.update(meetup_update_params)
      flash[:sucess] = "Game updated!"
      redirect_to court_path(@court)
    else
      flash[:alert] = @meetup.errors.full_messages.join(" - ")
      render :edit
    end
  end

  def destroy
    @meetup = Meetup.find(params["id"])
    @court = @meetup.court
    @meetup.destroy
    flash[:success] = "Game successfully deleted"
    redirect_to court_path(@court)
  end

  private

  def meetup_create_params
    meetup_info = params.permit(
      :description, :start_day, :start_hour, :start_minute
    )

    date = week_days[meetup_info[:start_day].to_i][0]
    hour = meetup_info[:start_hour].to_i
    minute = meetup_info[:start_minute].to_i
    description = meetup_info[:description]

    datetime = DateTime.new(date.year, date.month, date.day, hour, minute)

    {
      start_time: datetime,
      court: @court,
      user: current_user,
      description: description
    }
  end

  def meetup_update_params
    params.require(:meetup).permit(:condition)
  end
end
