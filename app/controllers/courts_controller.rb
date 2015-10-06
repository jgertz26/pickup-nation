class CourtsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @courts = Court.all
  end

  def show
    @court = Court.find(params["id"])
  end

  def new
    @court = Court.new
  end

  def create
    @court = Court.new(court_params)

    if @court.save
      flash[:notice] = "Court added!"
      redirect_to court_path(@court)
    else
      flash[:errors] = @court.errors.full_messages.join(" - ")
      render :new
    end
  end

  def edit
    @court = Court.find(params["id"])
  end

  def update
    @court = Court.find(params["id"])

    if @court.update(court_params)
      flash[:notice] = "Court updated!"
      redirect_to court_path(@court)
    else
      flash[:errors] = @court.errors.full_messages.join(" - ")
      render :edit
    end
  end

  def destroy
    @court = Court.find(params[:id])
    @court.destroy
    flash[:notice] = "Court deleted!"
    redirect_to root_path
  end

  private

  def court_params
    params.require(:court).permit(
      :name, :street_address, :city, :state, :zip, :hoop_count, :setting, :hours
    )
  end

  def require_login
    unless current_user
      flash[:error] = "You need to log in to do that!"
      redirect_to root_path
    end
  end
end
