require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/fa207a48646e39d34ef26f7fa9e3d869/" + @lat + "," + @lng
    parsed_data = JSON.parse(open(url).read)

    temp = parsed_data["currently"]["temperature"]
    sum = parsed_data["currently"]["summary"]
    sum_sixty_min = parsed_data["minutely"]["summary"]
    sum_hours = parsed_data["hourly"]["summary"]
    sum_days = parsed_data["daily"]["summary"]

    @current_temperature = temp

    @current_summary = sum

    @summary_of_next_sixty_minutes = sum_sixty_min

    @summary_of_next_several_hours = sum_hours

    @summary_of_next_several_days = sum_days

    render("forecast/coords_to_weather.html.erb")
  end
end
