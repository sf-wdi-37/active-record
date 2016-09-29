# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Database..."

Speaker.destroy_all
speakers_data = []

10.times do
  speakers_data << {
    first: FFaker::Name.first_name,
    last: FFaker::Name.last_name,
    email: FFaker::Internet.safe_email
  }
end

speakers = Speaker.create(speakers_data) # array of all created speakers
puts "Seeded #{speakers.count} speakers"

Talk.destroy_all

talks_data = []

10.times do
  talks_data << {
    topic: FFaker::Company.catch_phrase,
    duration: [30,45,60,90,nil].sample,
    start_time: FFaker::Time.date
  }
end

3.times do
  talks_data << {
    topic: nil,
    duration: [30,45,60,90,nil].sample,
    start_time: FFaker::Time.date
  }
end

talks = Talk.create(talks_data)

puts "Seeded #{talks.count} talks"
