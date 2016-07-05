if !@event.nil?
  if @event.valid?
    json.success true
    json.message "Event fetched succesfully"
    json.event do
      json.extract! @event, :id, :name, :date, :location, :latitude, :longitude, :user_id, :created_at, :updated_at, :token
      if !@event.photos.nil?
        json.photos @event.photos do |photo|
          json.partial! 'api/v1/events/photo', locals: { photo: photo }
        end
      end
    end
  else
    json.success false
    json.message @event.errors
  end
else
  json.success false
  json.message "Event not found"
end
