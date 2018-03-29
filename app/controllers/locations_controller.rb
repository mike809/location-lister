class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :destroy]

  def index
    @location = Location.new
    @locations = Location.all
  end

  def show
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully destroyed.'
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.fetch(:location, {})
    end
end
