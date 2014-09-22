class Teacher < ActiveRecord::Base
  resourcify
  include Authority::Abilities
  stampable #Also lets this model be user stamped
  belongs_to :user
  has_and_belongs_to_many :appointments
  has_many :students, through: :appointments
  has_and_belongs_to_many :skills, join_table: :teacher_skills
  has_and_belongs_to_many :specialties, join_table: :teacher_specialties
  has_and_belongs_to_many :certifications, join_table: :teacher_certifications
end
