class Appointment < ActiveRecord::Base
  include Authority::Abilities
  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  belongs_to :subject
end
