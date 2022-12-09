class MuseumsController < ApplicationController
  def home
    lng = params[:lng].to_f
    lat = params[:lat].to_f

    get_museums(lng, lat)
  end

  private

  def get_museums(lng, lat)
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?types=poi&proximity=#{lng},#{lat}&access_token=#{ENV['MAPBOX_API_KEY']}&limit=10"

    # If you'd like to search within a specific range of the coordinates, you
    # can comment out the above url variable, and uncomment the dst and url
    # variables below.
    # This one returns a bounding box around the given coordinates. Increase dst
    # if you want a larger search area, or decrease it for a narrower search
    # area. Of course, a wider search will potentially result in less precision
    # relative to the coordinates in your search.
    # dst = 0.0100
    # url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?types=poi&proximity=#{lng},#{lat}&access_token=#{ENV['MAPBOX_API_KEY']}&limit=10&bbox=#{lng - dst},#{lat -dst},#{lng +dst},#{lat +dst}"

    museums_serialized = URI.open(url).read
    museums = JSON.parse(museums_serialized)["features"]

    # This will store hashes. The key will be a postcode, and the value will be
    # an array of museums at that postcode.
    museums_by_postcode = {}

    museums.each do |museum|
      # The hash that stores the postcode is found in a "context" array, but the
      # postcode hash isn't always at the same index within that array. We need
      # to search specifically for the postcode hash.
      context_array = museum["context"]
      postcode_index = context_array.find_index { |hash| hash["id"].start_with?("postcode")}
      postcode = context_array[postcode_index]["text"]

      # If the museums_by_postcode hash doesn't already contain something at the
      # current museum's postcode, create a new key for that postcode, and make
      # the initial value an array containing only the current museum's name.
      # Otherwise, if there is already someting at that key, insert the current
      # museum name into array at that key.
      museum_name = museum["place_name"].split(",").first
      if museums_by_postcode[postcode].nil?
        museums_by_postcode[postcode] = [museum_name]
      else
        museums_by_postcode[postcode] << museum_name
      end
    end

    render json: museums_by_postcode
  end
end
