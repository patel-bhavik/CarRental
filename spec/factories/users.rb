FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    first_name Faker::Name.name
    last_name Faker::Name.name
    password "MyString"
    association :role, factory: :role, strategy: :create
  end

  trait :without_first_name do
    first_name ''
  end

  trait :without_last_name do
    last_name ''
  end

  trait :without_email do
    email ''
  end

  trait :invalid_password do
    password 'asdf'
  end

  trait :without_password do
    password ''
  end

  trait :with_admin_role do
    association :role, factory: [:role, :admin_role], strategy: :create
  end

  trait :with_super_admin_role do
    association :role, factory: [:role, :super_admin_role], strategy: :create
  end
end