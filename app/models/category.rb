class Category < ActiveRecord::Base
  attr_accessible :title

  #ha molte domande
  has_many :questions
end
