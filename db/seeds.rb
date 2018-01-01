# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create(name: 'SuperAdmin')
Role.create(name: 'Admin')
Role.create(name: 'Customer')
User.create(email: 'admin@gmail.com', first_name: 'Mr.', last_name: 'Admin', password: 'admin123', password_confirmation: 'admin123', role: Role.find_by_name('Admin'))
User.create(email: 'superadmin@gmail.com', first_name: 'Mr.', last_name: 'SuperAdmin', password: 'supadmin123', password_confirmation: 'supadmin123', role: Role.find_by_name('SuperAdmin'))
10.times do
  licence_no = [:abc, :xyz, :pqr, :lmn, :qwe].sample.to_s + rand(1000...9999).to_s
  manufacturer = [:Nissan, :Tesla, :Honda, :Hyundai, :Dodge, :Mercedes, :Audi, :Toyota, :Ford, :Volkswagen].sample.to_s
  model = [:Civic, :"Model X", :"Model S", :A8, :Viper, :Elentra, :Corolla, :CRV, :Sentra, :Passat, :Polo].sample.to_s
  style = [:Coupe, :Sedan, :SUV].sample.to_s
  rate = rand(30...100)
  location = [:Raleigh, :Cary, :Durham, :Charlotte, :Ashville].sample.to_s
  Car.create(licence_no: licence_no, manufacturer: manufacturer, model: model, style: style, hourly_rate: rate, location: location, status: 'Available')
end