namespace :db do

  desc "Fill database with sample data"

  task populate: :environment do

    admin = User.create!(name: "giulia",
                         email: "giulia@email.it",
                         password: "giulia89",
                         password_confirmation: "giulia89",
                         n_children: "2")

    admin.toggle!(:admin)

    20.times do |n|

      name  = Faker::Name.name
      email = "example-#{n+1}@newdad.it"
      password  = "password"
      children = rand(5)

      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   n_children: children)

    end

    users = User.all(limit: 10)
    50.times do
      post_content = Faker::Lorem.sentence(8)
      users.each { |user| user.posts.create!(content: post_content)}
    end
  end
end