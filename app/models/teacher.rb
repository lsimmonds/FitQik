class Teacher < ActiveRecord::Base
  include Authority::Abilities
  stampable #Also lets this model be user stamped
  belongs_to :user
  has_and_belongs_to_many :appointments
  has_many :students, through: :appointments
end
