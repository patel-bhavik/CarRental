json.extract! reservation, :id, :from, :to, :rental_charge, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
