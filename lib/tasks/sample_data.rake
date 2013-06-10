namespace :db do

  desc "Fill database with sample data"

  task populate: :environment do

    admin = User.create!(name: "Giulia Liberti",
                         email: "giulia.liberti@studenti.polito.it",
                         password: "newdad2013",
                         password_confirmation: "newdad2013")

    admin.toggle!(:admin)

    99.times do |n|

      name  = Faker::Name.name
      email = "example-#{n+1}@newdad.it"
      password  = "password"

      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)

    end
  end
end