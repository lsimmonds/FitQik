class Discipline < ActiveRecord::Base
  stampable #Also lets this model be user stamped

  has_many :subjects

end
