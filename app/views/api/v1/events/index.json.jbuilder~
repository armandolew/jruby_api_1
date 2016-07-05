if !@events.nil?
  json.success true
  json.message "Events fetched succesfully"
  json.events @events do |event|
    json.extract! event, :id, :name, :date, :location, :latitude, :longitude, :creator, :token
  end
else
  json.success true
  json.message "No events found"
end
