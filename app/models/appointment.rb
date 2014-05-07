class Appointment < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AppointmentAuthorizer'
  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  belongs_to :subject
end
