require 'rails_helper'

RSpec.describe User, type: :model do
  it 'user is valid if every field is valid' do
    user = build(:user)
    expect(user.valid?).to be true
    expect(user.customer?).to eq true
  end

  it 'first name should not be empty' do
    user = build(:user, :without_first_name)
    expect(user.valid?).to be false
  end

  it 'last name should not be empty' do
    user = build(:user, :without_last_name)
    expect(user.valid?).to be false
  end

  it 'email should not be empty' do
    user = build(:user, :without_email)
    expect(user.valid?).to be false
  end

  it '2 users cannot have the same employee ID' do
    user_with_an_email = build(:user)
    user_with_an_email.save
    user_with_the_same_email = build(:user)
    expect(user_with_the_same_email.valid?).to be false
  end

  it 'password should not be less than 6 charecters' do
    user = build(:user, :invalid_password)
    expect(user.valid?).to be false
  end

  it 'password should not be empty' do
    user = build(:user, :without_password)
    expect(user.valid?).to be false
  end

  it 'has role as admin if user with admin role is created' do
    user = create(:user, :with_admin_role)
    expect(user.role.name).to eq 'Admin'
    expect(user.admin?).to eq true
  end

  it 'has role as admin if user with admin role is created' do
    user = create(:user, :with_super_admin_role)
    expect(user.role.name).to eq 'SuperAdmin'
    expect(user.super_admin?).to eq true
  end
end
