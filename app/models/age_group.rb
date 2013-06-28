class AgeGroup < ActiveRecord::Base
  attr_accessible :name

  #una fascia d'età
  has_many :questions
end
