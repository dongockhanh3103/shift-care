# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

User.destroy_all
PlumberVehicle.destroy_all
PlumberJob.destroy_all
Job.destroy_all
Client.destroy_all
Plumber.destroy_all
Vehicle.destroy_all

User.create!(email: 'admin@example.com', name: 'admin', password: 'admin@123', password_confirmation: 'admin@123', role: :admin)
builder_vehicle_attrs = ['Honda', 'Vision', 'MT-09', 'S100-RR'].map do |type|
  {
    name: type,
    created_at: Time.current,
    updated_at: Time.current
  }
end
vehicles = Vehicle.create(builder_vehicle_attrs)

100.times do
  plumber = Plumber.create!(
    name: Faker::Name.unique.name,
    address: Faker::Address.full_address
  )

  PlumberVehicle.create!(
    plumber: plumber,
    vehicle: vehicles.sample
  )

  client = Client.create!(
    name: Faker::Name.unique.name,
    age: (18..100).to_a.sample,
    address: Faker::Address.full_address,
    private_note: Faker::Lorem.sentence
  )

  job = Job.create!(
    client: client,
    entry_time: Time.current + (1..10).to_a.sample.days
  )

  PlumberJob.create!(
    job: job,
    plumber: plumber
  )

  job.assigned!
end
