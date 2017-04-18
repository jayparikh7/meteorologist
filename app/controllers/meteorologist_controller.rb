require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ", "+")
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2 = "https://api.darksky.net/forecast/fa207a48646e39d34ef26f7fa9e3d869/" + latitude.to_s + "," + longitude.to_s
    parsed_data = JSON.parse(open(url2).read)

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

    render("meteorologist/street_to_weather.html.erb")
  end
end
