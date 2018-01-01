json.extract! car, :id, :licence_no, :manufacturer, :model, :style, :hourly_rate, :location, :status, :created_at, :updated_at
json.url car_url(car, format: :json)
