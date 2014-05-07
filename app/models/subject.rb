class Subject < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EditorAuthorizer'
  stampable #Also lets this model be user stamped

  belongs_to :discipline
end
