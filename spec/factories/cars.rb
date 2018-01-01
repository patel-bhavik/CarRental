FactoryGirl.define do
  factory :car do
    licence_no "ABCD123"
    manufacturer "MyManufacturer"
    model "MyModel"
    style "Sedan"
    hourly_rate 1.5
    location "MyLocation"
    status :available
  end

  trait :invalid_licence do
    licence_no 'asdf'
  end

  trait :invalid_hourly_rate do
    hourly_rate 'asd'
  end

  trait :negative_hourly_rate do
    hourly_rate -1.4
  end
end
