class Skills < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EditorAuthorizer'

  belongs_to :teacher
end
