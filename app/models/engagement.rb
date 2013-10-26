class Engagement < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  belongs_to :subject
end
