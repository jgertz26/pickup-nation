class CourtsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_admin, only: :destroy

  def index
    if params["location"].nil?
      user_location = get_user_location
      @range = 10
    else
      user_location = Geocoder.search(params["location"])[0]
      @range = params["range"]
    end

    page = params["page"]
    page ||= 1
    @user_coordinates = [user_location.latitude, user_location.longitude]
    @query_location = "#{user_location.city} #{user_location.state_code}"

    if Rails.env.test?
      @courts = Court.all.page(page)
    else
      @courts = Court.near(@user_coordinates, @range).page(page)
    end

    unless @courts.empty?
      @court_lats = @courts.map { |c| c.latitude }
      @court_lons = @courts.map { |c| c.longitude }
      @zoom = to_zoom(@courts.last, @user_coordinates)
    end
  end

  def show
    @court = Court.find(params["id"])
    meetups = @court.meetups
    @meetups_today = @court.meetups_today
    @meetups_this_week = @court.meetups_this_week
  end

  def new
    @court = Court.new
    @court_type_map = CourtType.all.map { |m| [m.description, m.id.to_i] }
  end

  def create
    @court = Court.new(court_params)
    if @court.save

      respond_to do |format|
        format.json do
          flash[:success] = "Court added!"
          render json: @court
        end
      end

    else
      respond_to do |format|
        format.json do
          flash[:alert] = @court.errors.full_messages.join(" - ")
          render json: @court.errors.full_messages.join(" - ")
        end
      end
    end
  end

  def edit
    @court = Court.find(params["id"])
  end

  def update
    @court = Court.find(params["id"])

    if @court.update(court_params)
      flash[:success] = "Court updated!"
      redirect_to court_path(@court)
    else
      flash[:alert] = @court.errors.full_messages.join(" - ")
      render :edit
    end
  end

  def destroy
    @court = Court.find(params[:id])
    @court.destroy
    flash[:success] = "Court deleted!"
    redirect_to root_path
  end

  private

  def court_params
    params.require(:court).permit(
      :name, :street_address, :city, :state, :zip,
      :hoop_count, :court_type_id, :hours, :latitude, :longitude
    )
  end

  def get_user_location
    if Rails.env.development? || Rails.env.test?
      Geocoder.search("33 Harrison Ave Boston MA 02111")[0]
    else
      request.location
    end
  end

  def require_admin
    unless current_user.admin
      flash[:alert] = "You must be an admin to do that!"
      redirect_to root_path
    end
  end

  def to_zoom(court, user_coordinates)
    distance = court.distance_from(user_coordinates)
    if distance < 1
      13
    elsif distance < 5
      11
    elsif distance < 15
      10
    else
      9
    end
  end
end
