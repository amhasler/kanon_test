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
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do |n|
      name = "The Republic Chapter #{n+1}"
      users.each { |user| user.artobjects.create!(name: name) }
    end
  end
end