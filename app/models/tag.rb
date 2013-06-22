class Tag < ActiveRecord::Base
  attr_accessible :title

  has_many :question_tags
end
