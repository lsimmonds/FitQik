class Discipline < ActiveRecord::Base
  include Authority::Abilities
  stampable #Also lets this model be user stamped

  has_many :subjects

end
