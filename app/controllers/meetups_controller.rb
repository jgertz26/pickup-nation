class MeetupsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @court = Court.find(params["court_id"])
    @meetup = Meetup.new
  end

  def create
    @court = Court.find(params["court_id"])
    @meetup = Meetup.new(meetup_create_params)

    if @meetup.save
      flash[:sucess] = "Meetup scheduled!"
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
      flash[:sucess] = "Meetup updated!"
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
    flash[:success] = "Meetup successfully deleted"
    redirect_to court_path(@court)
  end

  private

  def meetup_create_params
    params.require(:meetup).permit(:description, :start_time).merge(
      court: @court,
      user: current_user
    )
  end

  def meetup_update_params
    params.require(:meetup).permit(:condition)
  end
end
