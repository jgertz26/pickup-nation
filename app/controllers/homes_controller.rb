class HomesController < ApplicationController
  def index
    @range = 5
    @query_location = ""
  end
end
