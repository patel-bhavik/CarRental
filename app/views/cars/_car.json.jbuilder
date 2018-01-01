json.extract! car, :id, :licence_no, :manufacturer, :model, :style, :location, :hourly_rate, :status, :created_at, :updated_at
json.url car_url(car, format: :json)
