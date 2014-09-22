class Specialty < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'EditorAuthorizer'

  has_and_belongs_to_many :teacher
end
