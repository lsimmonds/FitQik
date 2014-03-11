class Subject < ActiveRecord::Base
  include Authority::Abilities
  stampable #Also lets this model be user stamped

  belongs_to :discipline
end
