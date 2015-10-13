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
    @query_location = "#{user_location.city}, #{user_location.state_code}"
    @courts = Court.near(@user_coordinates, @range).page(page)

    @court_lats = []
    @court_lons = []
    @courts.each do |court|
      @court_lats << court.latitude
      @court_lons << court.longitude
    end

    farthest_court_distance = @courts.last.distance_from(@user_coordinates)
    @zoom = to_zoom(farthest_court_distance)
  end

  def show
    @court = Court.find(params["id"])
    respond_to do |format|
      format.html
      format.json { render json: @court }
    end
  end

  def new
    @court = Court.new
  end

  def create
    @court = Court.new(court_params)

    if @court.save
      flash[:success] = "Court added!"
      redirect_to court_path(@court)
    else
      flash[:alert] = @court.errors.full_messages.join(" - ")
      render :new
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
      :hoop_count, :setting, :hours, :avatar
    )
  end

  def require_login
    unless current_user
      flash[:alert] = "You need to log in to do that!"
      redirect_to root_path
    end
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

  def to_zoom(distance)
    if distance < 5
      11
    elsif distance < 15
      10
    else
      9
    end
  end
end
