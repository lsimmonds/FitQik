class Admin < ActiveRecord::Base
  stampable #Also lets this model be user stamped
  resourcify
  include Authority::Abilities
  belongs_to :user
end
