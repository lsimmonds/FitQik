class Teacher < ActiveRecord::Base
  stampable #Also lets this model be user stamped
  belongs_to :user
  has_and_belongs_to_many :engagements
  has_many :students, through: :engagements
end
