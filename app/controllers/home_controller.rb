class HomeController < ApplicationController
  before_action :set_current_weather

  def index
  end

  private

  def set_current_weather
    client = OpenWeatherMap::Client.new
    data = client.current('Moscow')
    @current_temp = data['main']['temp']
    @current_pressure = data['main']['pressure']
    @current_wind_speed = data['wind']['speed']

  end

end

