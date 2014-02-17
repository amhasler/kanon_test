namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "amhasler@gmail.com",
                         password: "coltrane",
                         password_confirmation: "coltrane",
                         admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@PP1.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    images = []
    7.times do |n|
      images[n] = File.new(Rails.root + "spec/fixtures/images/image#{n+1}.jpg")
    end

    users = User.all(limit: 6)
    50.times do |n|
      name = "The Republic Chapter #{n+1}"
      mindate = 1170
      image = images[rand(7)]
      users.each { |user| user.artobjects.create!(name: name, minyear: mindate, image: image) }
    end
  end
end