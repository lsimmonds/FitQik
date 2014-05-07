class Discipline < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EditorAuthorizer'
  stampable #Also lets this model be user stamped

  has_many :subjects

end
