namespace :db do

  desc "Fill database with sample data"

  task populate: :environment do
    make_users
    make_posts
    make_relationships
    make_private_messages
    make_childrens
  end
end

def  make_users

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
    children = 2

    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 n_children: children)

  end
end

def make_posts

  users = User.all(limit: 10)
  50.times do
    post_content = Faker::Lorem.sentence(8)
    users.each { |user| user.posts.create!(content: post_content)}
  end
end

def make_relationships

  users = User.all
  user = users.first
  followed_users = users[2..15]
  followers = users[3..20]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }

end

def make_private_messages
  first_user = User.first
  users = User.all
  message_from_users = users[3..12]
  message_from_users.each do |user|
    msg_body = Faker::Lorem.sentence(8)
    msg_subject = Faker::Lorem.sentence(3)
    message = Message.new
    message.sender = user
    message.recipient = first_user
    message.subject = msg_subject
    message.body = msg_body
    message.save!
  end
end

def make_childrens
  users = User.all

 2.times do

  users.each { |user| user.childrens.create!(year: rand(1980..2013),
                                              month: rand(1..12),
                                              day: rand(1..31))}
   end
end