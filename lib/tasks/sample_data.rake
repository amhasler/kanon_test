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
      images << File.new(Rails.root + "spec/fixtures/images/image#{n+1}.jpg")
    end

    tags = ["Plato", "Socrates", "Greece", "Athens", "Attica", "Rhetoric", "Writing"]

    User.all.each do |n|
      n.artobjects.create!(
        name: "The Republic Chapter #{n.id}", 
        minyear: -400 + rand(1000), 
        image: images[rand(7)], 
        creator_list: tags[rand(6)], 
        location_list: tags[rand(6)], 
        society_list: tags[rand(6)], 
        language_list: tags[rand(6)], 
        medium_list: tags[rand(6)]
      )
    end
  end
end