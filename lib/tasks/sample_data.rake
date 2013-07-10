namespace :db do

  desc "Fill database with sample data"

  task populate: :environment do
    make_users
    make_posts
    make_relationships
    make_private_messages
    make_children
    make_tags
    make_categories
    make_age_groups
    make_questions
    make_answers
    #make_question_tag_relationship
  end
end

def  make_users

  admin = User.create!(name: "giulia",
                       email: "giulia@email.it",
                       password: "giulia89",
                       password_confirmation: "giulia89",
                       n_children: "2")

  admin.toggle!(:admin)

  admin2 = User.create!(name: "mari",
                       email: "mari@email.it",
                       password: "mari1234",
                       password_confirmation: "mari1234",
                       n_children: "0")

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

def make_children
  users = User.all

 2.times do

  users.each { |user| user.childrens.create!(birthday: rand(20.years).ago)}
   end
end

def make_tags
  Tag.create!(title: 'allergie')
  Tag.create!(title: 'cartoni animati')
  Tag.create!(title: 'denti')
  Tag.create!(title: 'film')
  Tag.create!(title: 'libri')
  Tag.create!(title: 'mare')
  Tag.create!(title: 'montagna')
  Tag.create!(title: 'pappe')
  Tag.create!(title: 'pannolini')
  Tag.create!(title: 'raffreddore')
  Tag.create!(title: 'scuola')
  Tag.create!(title: 'tosse')
end

def make_categories

  consigli = Category.create!(user_id: 1, title: "Consigli")
  consigli.toggle!(:waiting)
  consigli.toggle!(:accepted)

  educazione = Category.create!(user_id: 1,title: 'Educazione')
  educazione.toggle!(:waiting)
  educazione.toggle!(:accepted)

  giochi = Category.create!(user_id: 1,title: 'Giochi')
  giochi.toggle!(:waiting)
  giochi.toggle!(:accepted)

  ristoranti = Category.create!(user_id: 1,title: 'Ristoranti')
  ristoranti.toggle!(:waiting)
  ristoranti.toggle!(:accepted)

  salute = Category.create!(user_id: 1,title: 'Salute')
  salute.toggle!(:waiting)
  salute.toggle!(:accepted)

  vacanze = Category.create!(user_id: 1,title: 'Vacanze')
  vacanze.toggle!(:waiting)
  vacanze.toggle!(:accepted)
end

def make_age_groups
  AgeGroup.create!(name: '0-3 mesi')
  AgeGroup.create!(name: '3-6 mesi')
  AgeGroup.create!(name: '6-9 mesi')
  AgeGroup.create!(name: '9-12 mesi')
  AgeGroup.create!(name: '12-18 mesi')
  AgeGroup.create!(name: '18-24 mesi')
  AgeGroup.create!(name: '3-6 anni')
  AgeGroup.create!(name: '6-11 anni')
  AgeGroup.create!(name: '11-14 anni')
  AgeGroup.create!(name: '14-20 anni')
  AgeGroup.create!(name: '>20 anni')
end

def make_questions

  users = User.all(limit: 16)

  30.times do
    question_title = Faker::Lorem.sentence(6)
    question_content = Faker::Lorem.sentence(6)

    users.each { |user| user.questions.create!(title: question_title,
                                           category_id: rand(1..6),
                                           age_group_id: rand(1..11),
                                           content: question_content)}
  end

end

def make_answers

  users = User.all(limit: 13)
  questions = Question.all.count

  10.times do

    answer_content = Faker::Lorem.sentence(6)

    users.each{ |user| user.answers.create!(question_id: rand(questions+1),
                                            content: answer_content)}

  end

end

def make_question_tag_relationship

  questions = Question.all
  tags = Tag.all

  questions.each{ |question| question.tag!(tags.first)}
end

