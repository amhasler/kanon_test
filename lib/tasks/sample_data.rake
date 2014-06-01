namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "amhasler@gmail.com",
                         password: "coltrane",
                         password_confirmation: "coltrane",
                         admin: true)

    images = []
    7.times do |n|
      images << ImageUploader.new()
    end

    tags = ["Plato", "Socrates", "Greece", "Athens", "Attica", "Rhetoric", "Writing"]

    99.times do |n|

      name  = "username#{n*3}"
      email = "example-#{n+1}@PP1.com"
      password  = "password"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password,
                  creator_list: tags[rand(6)], 
                  location_list: tags[rand(6)], 
                  society_list: tags[rand(6)], 
                  language_list: tags[rand(6)], 
                  medium_list: tags[rand(6)])
    end

    

    User.all.each do |n|
      @uploader = ImageUploader.new(n.artobjects, :image)
      @uploader.cache!(File.open(Rails.root + "spec/fixtures/images/image#{(n.id+6)%7}.jpg"))

      n.artobjects.create!(
        name: "The Republic Chapter #{n.id}", 
        minyear: -400 + rand(1000), 
        image: @uploader, 
        creator_list: tags[rand(6)], 
        location_list: tags[rand(6)], 
        society_list: tags[rand(6)], 
        language_list: tags[rand(6)], 
        medium_list: tags[rand(6)]
      )
    end

    User.all.each do |n|
      n.favorite_objects << Artobject.find(rand(50)+1)
      n.favorite_objects << Artobject.find(rand(51..100))
    end
  end
end