require 'hashable'
class Appointment < ActiveRecord::Base
  include Hashable
  include Authority::Abilities
  self.authorizer_name = 'AppointmentAuthorizer'
  has_and_belongs_to_many :students
  has_and_belongs_to_many :teachers
  belongs_to :subject

  def self.on_date(date)
    where("DATE(CONVERT_TZ(`when`,'+00:00','-08:00')) = ?",date)
  end

end
