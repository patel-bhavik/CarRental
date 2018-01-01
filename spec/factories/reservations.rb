FactoryGirl.define do
  factory :reservation do
    from "2017-09-23 08:00:10"
    to "2017-09-23 10:00:10"
    rental_charge 1.5
  end
end
