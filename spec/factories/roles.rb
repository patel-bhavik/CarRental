FactoryGirl.define do
  factory :role do
    name 'Customer'
  end

  trait :admin_role do
    name 'Admin'
  end

  trait :super_admin_role do
    name 'SuperAdmin'
  end
end
